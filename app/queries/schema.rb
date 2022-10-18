# frozen_string_literal: true

class Schema < ::Introspec::BaseQuery
  type ::Types::Database::Schema, null: true

  def resolve
    database = ::Database.first
    {
      id:       database.id,
      database: database,
      tables:   database.tables
    }
  end
end
