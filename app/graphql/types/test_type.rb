# frozen_string_literal: true

module Types
  class TestType < ::Types::BaseObject
    field :status, Int, null: false
    field :message, String, null: false
  end
end
