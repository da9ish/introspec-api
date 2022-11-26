# frozen_string_literal: true

module Internal
  module Database
    class Schema < ::Configuration
      # create schema for table, columns, field resolvers, indexes
      def initialize(connection)
        @connection = connection
        @db = ::Database::DB(**connection)
      end
    end
  end
end
