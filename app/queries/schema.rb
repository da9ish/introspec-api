# frozen_string_literal: true

class Schema < ::Introspec::BaseQuery
  type ::Types::Database::Schema, null: true

  def resolve
    database = ::Database.first
    {
      database: database,
      tables:   database.tables
    }
  end
end
