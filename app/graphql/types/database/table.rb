# frozen_string_literal: true

module Types
  module Database
    class Table < ::Types::BaseObject
      field :name, String, null: false
      field :identifier, String, null: false
      field :indexes, [String]
      field :contraints, [String]
      field :columns, [::Types::Database::Column]
    end
  end
end
