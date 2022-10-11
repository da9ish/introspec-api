# frozen_string_literal: true

require "test_helper"

class TableTest < ActiveSupport::TestCase
  %i[table_user].each do |table|
    test "tables(:#{table}) is valid" do
      model = tables(table)
      assert model.valid?, "Expected tables(:#{table}) to be valid, got errors: #{model.errors.full_messages.to_sentence}"
    end
  end
end
