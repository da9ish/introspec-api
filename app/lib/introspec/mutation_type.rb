# frozen_string_literal: true

module Introspec
  class MutationType < ::Types::BaseObject
    def self.publish(klass, **kwargs, &block)
      field(klass.graphql_name, mutation: klass, **kwargs, &block)
    end
  end
end
