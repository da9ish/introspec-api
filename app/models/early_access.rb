# frozen_string_literal: true

class EarlyAccess < ApplicationRecord
  validates :email, presence: true
end
