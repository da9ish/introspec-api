# frozen_string_literal: true

class Column < ApplicationRecord
  include ::Identifiable

  DATA_TYPES = %w[BOOLEAN CHAR VARCHAR TEXT NUMERIC INTEGER SERIAL DATE TIMESTAMP INTERVAL TIME UUID JSON ARRAY].freeze
  CONSTRAINTS = %w['NOT NULL' UNIQUE PRIMARY FOREIGN CHECK EXCLUSION].freeze
  validates :data_type, inclusion: { in: DATA_TYPES, message: "'%{value}' is not one of #{DATA_TYPES.to_sentence}" }
  validates :contraints, array_inclusion: { in: CONSTRAINTS }

  belongs_to :table, class_name: "::Table", foreign_key: "table_id", primary_key: "id", inverse_of: :columns
end
