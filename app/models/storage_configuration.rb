# frozen_string_literal: true

class StorageConfiguration < ApplicationRecord
  include ::Identifiable
  include ::Namespaceable

  namespaced_association(:belongs_to, :bucket, { class_name: "::CloudStore::Bucket", primary_key: "id", inverse_of: :storage_configuration })
end
