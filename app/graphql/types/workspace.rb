# frozen_string_literal: true

module Types
  class Workspace < Types::BaseObject
    field :id, ID, null: false
    field :identifier, String, null: false
    field :name, String, null: false
    field :logo, String, null: false
    field :environments, [::Types::Environment], null: true
  end
end
