# frozen_string_literal: true

require "test_helper"

class UpdateTableTest < ActiveSupport::TestCase
  include Introspec::GraphqlTestHelper

  test "update table mutation test" do
    Current.test do
      mutation = mutation(:update_table, input: "updateTableInput!", selector: "name")
      result = execute(mutation, { input: {
                         id:         122_001_029,
                         name:       "test1",
                         identifier: "test1",
                         columns:    []
                       } })

      assert result["errors"].nil?, "Test field query failed. ERR: #{result['errors']}"
    end
  end
end
