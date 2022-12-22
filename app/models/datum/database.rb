# frozen_string_literal: true

module Datum
  class Database < ApplicationRecord
    include ::Identifiable
    include ::Namespaceable

    namespaced_association(:belongs_to, :environment, { class_name: "::Environment", primary_key: "id", inverse_of: :databases })
    namespaced_association(:has_many, :tables, { class_name: "::Datum::Table", dependent: :destroy })
    namespaced_association(:has_one, :configurations, { class_name: "::Datum::Configuration", dependent: :destroy })
    # belongs_to :environment, class_name: "::Environment", primary_key: "id", inverse_of: :databases
    # has_many :tables, dependent: :destroy
  end
end
