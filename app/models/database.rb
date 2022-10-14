# frozen_string_literal: true

class Database < ApplicationRecord
  include ::Identifiable

  belongs_to :environment, class_name: "::Environment", primary_key: "id", inverse_of: :databases
  has_many :tables, dependent: :destroy
end
