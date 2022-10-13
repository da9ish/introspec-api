# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :current_account, ::Types::User, null: true, authenticate: false

    def current_account
      if context[:current_resource]
        ap "Authenticated user on public field: #{context[:current_resource].email}"
        return context[:current_resource]
      else
        ap 'Field does not require authentication'
      end
    end
  end
end
