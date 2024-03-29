# frozen_string_literal: true

module Types
  module Storage
    class File < ::Types::BaseObject
      field :id, ID, null: false
      field :bucket_id, ID, null: false
      field :identifier, String, null: false
      field :name, String, null: false
      field :relative_path, String, null: false
      field :size, Types::ByteType, null: false
      field :file_type, String, null: false
      field :created_at, Types::DateTimeType, null: false
      field :updated_at, Types::DateTimeType, null: false
    end
  end
end
