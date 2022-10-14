# frozen_string_literal: true

module Types
  module Database
    class Column < ::Types::BaseObject
      field :identifier, String, null: false
      field :name, String, null: false
      field :data_type, String
      field :contraints, [String]
    end
  end
end
