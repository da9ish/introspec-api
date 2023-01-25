# frozen_string_literal: true

module Types
  module Database
    class Schema < ::Types::BaseObject
      field :id, ID, null: false
      field :database, ::Types::Database::Database, null: false
    end
  end
end
