# frozen_string_literal: true

class UpdateTable < ::Introspec::BaseMutation
  argument :id, ID, required: true
  argument :name, String, required: false
  argument :identifier, String, required: false

  type ::Types::Database::Table, null: true

  def resolve(id:, **kwargs)
    @id = id
    update_table(kwargs)
  end

  def update_table(kwargs)
    # TODO: add workspace and env management
    table.update(id: @id, **kwargs)
    table
  end

  def table
    @table ||= ::Datum::Table.find(@id)
  end
end
