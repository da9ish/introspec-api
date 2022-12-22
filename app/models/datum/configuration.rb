# frozen_string_literal: true

module Datum
  class Configuration < ApplicationRecord
    include ::Namespaceable

    namespaced_association(:belongs_to, :database, { class_name: "::Datum::Database", primary_key: "id", inverse_of: :configurations })
  end
end
