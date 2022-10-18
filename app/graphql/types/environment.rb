# frozen_string_literal: true

module Types
  class Environment < Types::BaseObject
    field :id, ID, null: false
    field :identifier, String, null: false
    field :name, String, null: false
  end
end
