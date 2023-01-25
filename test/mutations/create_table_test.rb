# frozen_string_literal: true

require "test_helper"

class CreateTableTest < ActiveSupport::TestCase
  include Introspec::GraphqlTestHelper

  test "create table mutation test" do
    Current.test do
      mutation = mutation(:create_table, input: "createTableInput!", selector: "name")
      result = execute(mutation, { input: {
                         name:        "test1",
                         identifier:  "test1",
                         database_id: 836_425_801,
                         columns:     []
                       } })

      assert result["errors"].nil?, "Test field query failed. ERR: #{result['errors']}"
    end
  end
end
