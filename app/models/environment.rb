# frozen_string_literal: true

class Environment < ApplicationRecord
  include ::Identifiable
  include ::Namespaceable

  belongs_to :workspace, class_name: "::Workspace", primary_key: "id", inverse_of: :environments
  namespaced_association(:has_many, :databases, { class_name: "::Datum::Database", dependent: :destroy })
  # has_many :databases, dependent: :destroy
end
