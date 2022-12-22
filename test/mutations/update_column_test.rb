# frozen_string_literal: true

require "test_helper"

class UpdateColumnTest < ::ActiveSupport::TestCase
  include Introspec::GraphqlTestHelper

  test "update column mutation test" do
    Current.test do
      mutation = mutation(:update_column, input: "updateColumnInput!", selector: "name")
      result = execute(mutation, { input: {
                         id:          16_861_542,
                         name:        "test1",
                         identifier:  "test1",
                         data_type:   "VARCHAR",
                         is_indexed:  true,
                         constraints: []
                       } })

      assert result["errors"].nil?, "Test field query failed. ERR: #{result['errors']}"
    end
  end
end
