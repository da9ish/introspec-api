# frozen_string_literal: true

class Database < ApplicationRecord
  include ::Identifiable

  belongs_to :environment, class_name: "::Environment", foreign_key: true, primary_key: "identifier"
  has_many :tables
end
