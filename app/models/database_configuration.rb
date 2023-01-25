# frozen_string_literal: true

class DatabaseConfiguration < ApplicationRecord
  include ::Identifiable
  include ::Namespaceable

  namespaced_association(:belongs_to, :database, { class_name: "::Datum::Database", primary_key: "id", inverse_of: :database_configuration })
end
