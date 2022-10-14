# frozen_string_literal: true

module Types
  module Database
    class Schema < ::Types::BaseObject
      field :database, ::Types::Database::Database, null: false
      field :tables, [::Types::Database::Table], null: false
    end
  end
end
