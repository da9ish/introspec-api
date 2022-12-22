# frozen_string_literal: true

module Types
  module Database
    class Database < ::Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :identifier, String, null: false
    end
  end
end
