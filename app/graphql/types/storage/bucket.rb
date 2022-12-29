# frozen_string_literal: true

module Types
  module Storage
    class Bucket < ::Types::BaseObject
      field :id, ID, null: false
      field :identifier, String, null: false
      field :name, String, null: false
    end
  end
end
