# frozen_string_literal: true

module Types
  module Database
    class CreateColumnAttributes < Types::BaseInputObject
      argument :name, String, required: true
      argument :identifier, String, required: true
      argument :data_type, ::Types::DataTypeEnum, required: true
      argument :default_value, String
      argument :is_array, Boolean
      argument :is_indexed, Boolean
      argument :is_primary, Boolean
      argument :is_unique, Boolean
      argument :is_nullable, Boolean
    end
  end
end
