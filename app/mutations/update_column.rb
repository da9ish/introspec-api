# frozen_string_literal: true

class UpdateColumn < Introspec::BaseMutation
  argument :id, ID, required: true
  argument :name, String, required: false
  argument :identifier, String, required: false
  argument :data_type, ::Types::DataTypeEnum, required: true
  argument :default_value, String
  argument :is_array, Boolean
  argument :is_indexed, Boolean
  argument :is_primary, Boolean
  argument :is_unique, Boolean
  argument :is_nullable, Boolean

  type ::Types::Database::Column, null: true

  def resolve(id:, **kwargs)
    @id = id
    update_column(kwargs)
  end

  def update_column(kwargs)
    column.update(id: @id, **kwargs)
    column
  end

  def column
    @column ||= ::Datum::Column.find(@id)
  end
end
