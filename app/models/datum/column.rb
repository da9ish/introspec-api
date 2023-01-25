# frozen_string_literal: true

module Datum
  class Column < ApplicationRecord
    include ::Identifiable
    include ::Namespaceable

    DATA_TYPES = %w[int2 int4 int8 float4 float8 numeric json jsonb text varchar uuid date time timetz timestamp timestamptz bool].freeze
    validates :data_type, inclusion: { in: DATA_TYPES, message: "'%{value}' is not one of #{DATA_TYPES.to_sentence}" }

    namespaced_association(:belongs_to, :table, { class_name: "::Datum::Table", primary_key: "id", inverse_of: :columns })
  end
end
