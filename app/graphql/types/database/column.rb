# frozen_string_literal: true

module Types
  module Database
    class Column < ::Types::BaseObject
      field :id, ID, null: false
      field :table_id, ID, null: false
      field :identifier, String, null: false
      field :name, String, null: false
      field :data_type, ::Types::DataTypeEnum, null: false
      field :default_value, String
      field :is_array, Boolean
      field :is_indexed, Boolean
      field :is_primary, Boolean
      field :is_unique, Boolean
      field :is_nullable, Boolean
    end
  end
end
