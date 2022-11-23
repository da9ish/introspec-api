# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require_relative "../app/lib/introspec/graphql_test_helper"
require_relative "../app/lib/aws/database"
require_relative "../app/lib/aws/storage"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    Minitest::Test.make_my_diffs_pretty!

    def self.focus
      return puts("   ****** Ignoring focus ****** ") if ENV["NOFOCUS"]

      super
    end
  end
end
