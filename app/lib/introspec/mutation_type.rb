# frozen_string_literal: true

module Introspec
  class MutationType < ::Types::BaseObject
    def self.publish(klass, **kwargs, &block)
      field_name = klass.to_s.include?("Introspec") ? klass.to_s.split("::").last.gsub("::", "").underscore : klass.graphql_name
      field(field_name, mutation: klass, **kwargs, &block)
    end
  end
end
