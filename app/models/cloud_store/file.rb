# frozen_string_literal: true

module CloudStore
  class File < ApplicationRecord
    include ::Identifiable
    include ::Namespaceable

    FILE_TYPE = %w[image video document].freeze
    validates :file_type, inclusion: { in: FILE_TYPE, message: "'%{value}' is not one of #{FILE_TYPE.to_sentence}" }

    namespaced_association(:belongs_to, :bucket, { class_name: "::CloudStore::Bucket", primary_key: "id", inverse_of: :files, optional: true })
    namespaced_association(:belongs_to, :folder, { class_name: "::CloudStore::Folder", primary_key: "id", inverse_of: :files, optional: true })
  end
end
