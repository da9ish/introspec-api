# frozen_string_literal: true

module Types
  module Storage
    class File < ::Types::BaseObject
      field :id, ID, null: false
      field :bucket_id, ID, null: false
      field :identifier, String, null: false
      field :name, String, null: false
      field :relative_path, String, null: false
      field :size, String, null: false
      field :file_type, String, null: false
    end
  end
end
