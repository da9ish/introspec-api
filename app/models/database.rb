# frozen_string_literal: true

class Database < ApplicationRecord
  include ::Identifiable

  belongs_to :environment, class_name: "::Environment", foreign_key: "environment_id", primary_key: "id", inverse_of: :databases
  has_many :tables
end
