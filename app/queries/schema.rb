# frozen_string_literal: true

class Schema < ::Introspec::BaseQuery
  type ::Types::Database::Schema, null: true

  def resolve
    database = ::Database.first
    response = {
      id: database.id,
      database: database,
      tables:   database.tables
    }
    return response
  end
end
