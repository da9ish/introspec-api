# frozen_string_literal: true

module Storage
  class Directory < ::Introspec::BaseQuery
    type ::Types::Storage::Directories, null: true

    argument :path, String, required: true

    def resolve(path:)
      bucket = ::CloudStore::Bucket.where(environment_id: Current.environment.id).first
      folders = bucket.folders.where("relative_path LIKE :prefix", prefix: "#{path}%") || []
      parent_folder = folders.count.positive? ? folders.first.parent_folder : nil
      sub_folders = folders.map(&:sub_folders).flatten || []

      {
        bucket:        bucket,
        path:          path,
        parent_folder: parent_folder,
        folders:       folders,
        sub_folders:   sub_folders,
        files:         bucket.files.where("relative_path LIKE :prefix", prefix: "#{path}%")
      }
    end
  end
end
