# frozen_string_literal: true

require "test_helper"

module Datum
  class ColumnTest < ActiveSupport::TestCase
    %i[column_name].each do |column|
      test "columns(:#{column}) is valid" do
        model = datum_columns(column)
        assert model.valid?, "Expected columns(:#{column}) to be valid, got errors: #{model.errors.full_messages.to_sentence}"
      end
    end
  end
end
