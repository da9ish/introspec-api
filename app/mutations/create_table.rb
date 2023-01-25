# frozen_string_literal: true

class CreateTable < Introspec::BaseMutation
  argument :database_id, ID, required: true
  argument :name, String, required: true
  argument :identifier, String, required: true
  argument :columns, [::Types::Database::CreateColumnAttributes]

  type ::Types::Database::Table, null: true

  def resolve(database_id:, name:, identifier:, columns:)
    @database_id = database_id
    @name = name
    @identifier = identifier
    @columns = columns
    # TOOD: move this in a seperate job
    # @connection = ::Database::Connection.new(database.database_configuration.host, database.database_configuration.db_name, database.database_configuration.username, database.database_configuration.encrypted_password).connection
    # create_table_in_db &&
    create_table
  end

  def create_table_in_db
    @connection.create_table(@name.to_sym)
    @columns.map do |col|
      @connection.add_column(
        @name.to_sym,
        col.identifier,
        col.is_primary ? :primary : ACTIVE_RECORD_DATA_TYPE_MAP[col.data_type],
        {
          default: col.default_value,
          null:    col.is_nullable,
          array:   col.is_array
        }
      )
      next unless col.is_indexed

      @connection.add_index(
        @name.to_sym,
        col.identifier,
        {
          unique: col.is_unique
        }
      )
    end
  end

  def create_table
    # TODO: add workspace and env management
    table = Datum::Table.create!(name: @name, identifier: @identifier, database: database)
    @columns.map do |col|
      create_column(table[:id], col)
    end
    table
  end

  def create_column(table_id, col)
    # TODO: add workspace and env management
    ::Datum::Column.create!(table_id: table_id, **col)
  end

  def database
    @database ||= ::Datum::Database.find(@database_id)
  end
end
