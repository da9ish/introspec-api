# frozen_string_literal: true

require "test_helper"

class CreateColumnTest < ::ActiveSupport::TestCase
  include Introspec::GraphqlTestHelper

  test "create column mutation test" do
    Current.test do
      mutation = mutation(:create_column, input: "createColumnInput!", selector: "name")
      result = execute(mutation, { input: {
                         name:        "test",
                         identifier:  "test",
                         table_id:    122_001_029,
                         data_type:   "TEXT",
                         is_indexed:  false,
                         constraints: []
                       } })

      assert result["errors"].nil?, "Test field query failed. ERR: #{result['errors']}"
    end
  end
end
