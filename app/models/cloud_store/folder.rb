# frozen_string_literal: true

module CloudStore
  class Folder < ApplicationRecord
    include ::Identifiable
    include ::Namespaceable

    namespaced_association(:belongs_to, :bucket, {
                             class_name:  "::CloudStore::Bucket",
                             primary_key: "id",
                             foreign_key: "bucket_id",
                             inverse_of:  :folders
                           })
    namespaced_association(:belongs_to, :parent_folder, {
                             class_name:  "::CloudStore::Folder",
                             primary_key: "id",
                             foreign_key: "folder_id",
                             inverse_of:  :sub_folders,
                             optional:    true
                           })
    namespaced_association(:has_many, :sub_folders, {
                             class_name:  "::CloudStore::Folder",
                             foreign_key: "folder_id",
                             dependent:   :destroy
                           })
    namespaced_association(:has_many, :files, {
                             class_name: "::CloudStore::File",
                             dependent:  :destroy
                           })

    def size
      files.map(&:size).sum + sub_folders.map(&:size).sum
    end
  end
end
