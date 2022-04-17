# frozen_string_literal: true

class Table < ApplicationRecord
  include ::Identifiable

  belongs_to :database, class_name: "::Database", foreign_key: true, primary_key: "identifier", inverse_of: "column"
  has_many :columns
end
