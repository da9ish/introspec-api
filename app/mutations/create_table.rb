# frozen_string_literal: true

class CreateTable < ::Introspec::BaseMutation
  argument :database_id, ID, required: true
  argument :name, String, required: true
  argument :identifier, String, required: true

  type ::Types::Database::Table, null: true

  def resolve(database_id:, name:, identifier:)
    @database_id = database_id
    @name = name
    @identifier = identifier
    create_table
  end

  def create_table
    # TODO: add workspace and env management
    ::Datum::Table.create!(name: @name, identifier: @identifier, database_id: database.id)
  end

  def database
    @database ||= ::Datum::Database.find(@database_id)
  end
end
