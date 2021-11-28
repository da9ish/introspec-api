# frozen_string_literal: true

class Workspace < ApplicationRecord
  validates :identifier, :name, presence: true
end
