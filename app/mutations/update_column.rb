# frozen_string_literal: true

class UpdateColumn < ::Introspec::BaseMutation
  argument :id, ID, required: true
  argument :name, String, required: false
  argument :identifier, String, required: false
  argument :data_type, ::Types::DataTypeEnum, required: false
  argument :is_indexed, Boolean, required: false
  argument :constraints, [::Types::ConstraintsEnum], required: false

  type ::Types::Database::Column, null: true

  def resolve(id:, **kwargs)
    @id = id
    create_column(kwargs)
  end

  def create_column(kwargs)
    column.update(id: @id, **kwargs)
    column
  end

  def column
    @column ||= ::Datum::Column.find(@id)
  end
end
