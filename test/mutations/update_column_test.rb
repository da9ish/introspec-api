# frozen_string_literal: true

require "test_helper"

class UpdateColumnTest < ActiveSupport::TestCase
  include Introspec::GraphqlTestHelper

  test "update column mutation test" do
    Current.test do
      mutation = mutation(:update_column, input: "updateColumnInput!", selector: "name")
      result = execute(mutation, { input: {
                         id:            16_861_542,
                         name:          "test1",
                         identifier:    "test1",
                         data_type:     "varchar",
                         default_value: "",
                         is_primary:    false,
                         is_nullable:   true,
                         is_array:      false,
                         is_unique:     false,
                         is_indexed:    true
                       } })

      assert result["errors"].nil?, "Test field query failed. ERR: #{result['errors']}"
    end
  end
end
