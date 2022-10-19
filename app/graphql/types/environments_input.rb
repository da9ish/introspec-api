# frozen_string_literal: true

module Types
  class EnvironmentsInput < Types::BaseInputObject
    argument :name, String, required: true
    argument :identifier, String, required: true
  end
end
