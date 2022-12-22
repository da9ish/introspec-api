# frozen_string_literal: true

module Datum
  class Table < ApplicationRecord
    include ::Identifiable
    include ::Namespaceable

    namespaced_association(:belongs_to, :database, { class_name: "::Datum::Database", primary_key: "id", inverse_of: :tables })
    namespaced_association(:has_many, :columns, { dependent: :destroy })
  end
end
