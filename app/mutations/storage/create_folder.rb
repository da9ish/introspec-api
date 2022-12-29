# frozen_string_literal: true

module Storage
  class CreateFolder < ::Introspec::BaseMutation
    argument :bucket_id, ID, required: true
    argument :folder_id, ID, required: false
    argument :name, String, required: true
    argument :identifier, String, required: true
    argument :relative_path, String, required: true

    type ::Types::Storage::Folder, null: true

    def resolve(bucket_id:, folder_id:, name:, identifier:, relative_path:)
      @bucket_id = bucket_id
      @folder_id = folder_id
      @name = name
      @identifier = identifier
      @relative_path = "#{relative_path}/#{identifier}"
      create_folder
    end

    def create_folder
      # TODO: add workspace and env management
      ::CloudStore::Folder.create!(name: @name, identifier: @identifier, relative_path: @relative_path, folder_id: @folder_id, bucket_id: bucket.id)
    end

    def bucket
      @bucket ||= ::CloudStore::Bucket.find(@bucket_id)
    end
  end
end
