# frozen_string_literal: true

class UpdateTable < Introspec::BaseMutation
  argument :id, ID, required: true
  argument :name, String, required: false
  argument :identifier, String, required: false
  argument :columns, [::Types::Database::CreateColumnAttributes]

  type ::Types::Database::Table, null: true

  def resolve(id:, columns:, **kwargs)
    @id = id
    @columns = columns
    update_table(kwargs)
  end

  def update_table(kwargs)
    # TODO: add workspace and env management
    table.update(id: @id, **kwargs)
    @columns.map do |col|
      update_column(col)
    end
    table
  end

  def update_column(col)
    column = ::Datum::Column.find(col.id)
    column.update(**col)
    column
  end

  def table
    @table ||= ::Datum::Table.find(@id)
  end
end
