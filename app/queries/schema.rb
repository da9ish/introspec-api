# frozen_string_literal: true

class Schema < ::Introspec::BaseQuery
  type ::Types::Database::Schema, null: true

  def resolve
    database = ::Datum::Database.where(environment_id: Current.environment.id).first
    if database
      {
        id:       database.id,
        database: database,
        tables:   database.tables
      }
    end
  end
end
