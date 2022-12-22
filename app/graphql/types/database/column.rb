# frozen_string_literal: true

module Types
  module Database
    class Column < ::Types::BaseObject
      field :id, ID, null: false
      field :table_id, ID, null: false
      field :identifier, String, null: false
      field :name, String, null: false
      field :data_type, String
      field :is_indexed, Boolean
      field :constraints, [String]
    end
  end
end
