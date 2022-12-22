# frozen_string_literal: true

require "test_helper"

module Datum
  class DatabaseTest < ActiveSupport::TestCase
    %i[introspec_api].each do |database|
      test "databases(:#{database}) is valid" do
        model = datum_databases(database)
        assert model.valid?, "Expected databases(:#{database}) to be valid, got errors: #{model.errors.full_messages.to_sentence}"
      end
    end
  end
end
