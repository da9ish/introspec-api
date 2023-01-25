# frozen_string_literal: true

module Types
  module Database
    class Table < ::Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :identifier, String, null: false
      field :cols, [::Types::Database::Column]

      def cols
        AssociationLoader.for(::Datum::Table, :columns).load(object)
      end
    end
  end
end
