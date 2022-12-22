# frozen_string_literal: true

module Datum
  class Column < ApplicationRecord
    include ::Identifiable
    include ::Namespaceable

    DATA_TYPES = %w[BOOLEAN CHAR VARCHAR TEXT NUMERIC INTEGER SERIAL DATE TIMESTAMP INTERVAL TIME UUID JSON ARRAY].freeze
    CONSTRAINTS = %w[NOT_NULL UNIQUE PRIMARY FOREIGN CHECK EXCLUSION].freeze
    validates :data_type, inclusion: { in: DATA_TYPES, message: "'%{value}' is not one of #{DATA_TYPES.to_sentence}" }
    validates :constraints, array_inclusion: { in: CONSTRAINTS }

    namespaced_association(:belongs_to, :table, { class_name: "::Datum::Table", primary_key: "id", inverse_of: :columns })
  end
end
