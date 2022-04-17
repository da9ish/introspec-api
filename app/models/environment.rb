# frozen_string_literal: true

class Environment < ApplicationRecord
  include ::Identifiable

  belongs_to :workspace, class_name: "::Workspace", foreign_key: true, primary_key: "identifier"
  has_many :databases
end
