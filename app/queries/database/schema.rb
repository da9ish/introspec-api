# frozen_string_literal: true

module Database
  class Schema < ::Introspec::BaseQuery
    type ::Types::Database::Schema, null: true

    # argument :table_id, String, required: true

    def resolve
      database = ::Datum::Database.where(environment_id: context[:environment_id]).first
      return unless database

      {
        id:       database.id,
        database: database
      }
    end
  end
end
