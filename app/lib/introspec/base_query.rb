# frozen_string_literal: true

module Introspec
  class BaseQuery < GraphQL::Schema::Resolver
    def record_not_found
      raise GraphQL::ExecutionError, "Record not found"
    end
  end
end
