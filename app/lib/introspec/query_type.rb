# frozen_string_literal: true

module Introspec
  class QueryType < ::Types::BaseObject
    def self.query(klass, options)
      field_name = klass.to_s.include?("Introspec") ? klass.to_s.split("::").last.gsub("::", "").underscore : klass.to_s.gsub("::", "").underscore
      field(field_name, resolver: klass, authenticate: options[:authenticate])
    end
  end
end
