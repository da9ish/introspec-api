# frozen_string_literal: true

class Environment < ApplicationRecord
  include ::Identifiable
  
  belongs_to :workspace, class_name: "::Workspace", foreign_key: "workspace_id", primary_key: "id", inverse_of: :environments
  has_many :databases
end