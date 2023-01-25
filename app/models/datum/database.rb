# frozen_string_literal: true

module Datum
  class Database < ApplicationRecord
    include ::Identifiable
    include ::Namespaceable

    namespaced_association(:belongs_to, :environment, { class_name: "::Environment", primary_key: "id", inverse_of: :databases })
    namespaced_association(:has_many, :tables, { class_name: "::Datum::Table", dependent: :destroy })
    namespaced_association(:has_one, :database_configuration, { class_name: "::DatabaseConfiguration", foreign_key: :database_id, dependent: :destroy })
  end
end
