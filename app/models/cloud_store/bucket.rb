# frozen_string_literal: true

module CloudStore
  class Bucket < ApplicationRecord
    include ::Identifiable
    include ::Namespaceable

    namespaced_association(:belongs_to, :environment, { class_name: "::Environment", primary_key: "id", inverse_of: :buckets })
    namespaced_association(:has_many, :folders, { class_name: "::CloudStore::Folder", dependent: :destroy })
    namespaced_association(:has_many, :files, { class_name: "::CloudStore::File", dependent: :destroy })
    namespaced_association(:has_one, :storage_configuration, { class_name: "::StorageConfiguration", foreign_key: :bucket_id, dependent: :destroy })
  end
end
