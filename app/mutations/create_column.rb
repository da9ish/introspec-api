# frozen_string_literal: true

class CreateColumn < ::Introspec::BaseMutation
  argument :table_id, ID, required: true
  argument :name, String, required: true
  argument :identifier, String, required: true
  argument :is_indexed, Boolean
  argument :data_type, ::Types::DataTypeEnum, required: true
  argument :constraints, [::Types::ConstraintsEnum]

  type ::Types::Database::Column, null: true

  def resolve(table_id:, name:, identifier:, data_type:, is_indexed:, constraints:)
    @table_id = table_id
    @name = name
    @identifier = identifier
    @data_type = data_type
    @is_indexed = is_indexed
    @constraints = constraints
    create_column
  end

  def create_column
    # TODO: add workspace and env management
    ::Datum::Column.create!(name: @name, identifier: @identifier, data_type: @data_type, is_indexed: @is_indexed, constraints: @constraints, table_id: table.id)
  end

  def table
    @table ||= ::Datum::Table.find(@table_id)
  end
end
