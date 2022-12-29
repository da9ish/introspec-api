# frozen_string_literal: true

module Database
  class Schema < ::Introspec::BaseQuery
    type ::Types::Database::Schema, null: true

    def resolve
      database = ::Datum::Database.where(environment_id: Current.environment.id).first
      # rubocop:disable Style/GuardClause
      if database
        {
          id:       database.id,
          database: database,
          tables:   database.tables
        }
      end
      # rubocop:enable Style/GuardClause
    end
  end
end
