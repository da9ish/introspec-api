# frozen_string_literal: true

module Introspec
  class QueryType < ::Types::BaseObject
    def self.query(klass, authenticate)
      field(klass.to_s.gsub("::", "").underscore, resolver: klass, authenticate: authenticate)
    end
  end
end
