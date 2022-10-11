# frozen_string_literal: true

class Table < ApplicationRecord
  include ::Identifiable

  belongs_to :database, class_name: "::Database", foreign_key: "database_id", primary_key: "id", inverse_of: :tables
  has_many :columns
end
