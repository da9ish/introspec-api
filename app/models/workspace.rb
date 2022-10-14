# frozen_string_literal: true

class Workspace < ApplicationRecord
  include ::Identifiable

  def self.introspec_workspace
    @introspec_workspace ||= readonly.find_by(identifier: "introspec")
  end

  has_many :environments, dependent: :destroy
end
