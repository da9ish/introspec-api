# frozen_string_literal: true

module Types
  module Storage
    class Folder < ::Types::BaseObject
      field :id, ID, null: false
      field :bucket_id, ID, null: false
      field :identifier, String, null: false
      field :name, String, null: false
      field :relative_path, String, null: false
      field :size, Types::ByteType, null: false
      field :created_at, Types::DateTimeType, null: false
      field :updated_at, Types::DateTimeType, null: false
    end
  end
end
