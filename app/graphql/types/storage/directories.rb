# frozen_string_literal: true

module Types
  module Storage
    class Directories < ::Types::BaseObject
      field :bucket, ::Types::Storage::Bucket, null: false
      field :path, String, null: false
      field :parent_folder, ::Types::Storage::Folder, null: true
      field :folders, [::Types::Storage::Folder], null: false
      field :sub_folders, [::Types::Storage::Folder], null: false
      field :files, [::Types::Storage::File], null: false
    end
  end
end
