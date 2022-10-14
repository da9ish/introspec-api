# frozen_string_literal: true

class Environment < ApplicationRecord
  include ::Identifiable

  belongs_to :workspace, class_name: "::Workspace", primary_key: "id", inverse_of: :environments
  has_many :databases, dependent: :destroy
end
