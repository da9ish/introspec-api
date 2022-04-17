# frozen_string_literal: true

class Workspace < ApplicationRecord
  include ::Identifiable

  has_many :environments
end
