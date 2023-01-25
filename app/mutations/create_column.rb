# frozen_string_literal: true

class CreateColumn < Introspec::BaseMutation
  argument :table_id, ID, required: true
  argument :name, String, required: true
  argument :identifier, String, required: true
  argument :data_type, ::Types::DataTypeEnum, required: true
  argument :default_value, String
  argument :is_array, Boolean
  argument :is_indexed, Boolean
  argument :is_primary, Boolean
  argument :is_unique, Boolean
  argument :is_nullable, Boolean

  type ::Types::Database::Column, null: true

  def resolve(table_id:, **kwargs)
    @table_id = table_id
    create_column(kwargs)
  end

  def create_column(kwargs)
    # TODO: add workspace and env management
    ::Datum::Column.create!(table_id: table.id, **kwargs)
  end

  def table
    @table ||= ::Datum::Table.find(@table_id)
  end
end
