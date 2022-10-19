# frozen_string_literal: true

require "test_helper"

class CreateWorkspaceTest < ::ActiveSupport::TestCase
  include Introspec::GraphqlTestHelper

  test "create workspace mutation test" do
    Current.test do
      mutation = mutation(:create_workspace, input: "createWorkspaceInput!", selector: "name")
      result = execute(mutation, { input: {
                         name:       "test",
                         identifier: "test"
                       } })

      assert result["errors"].nil?, "Test field query failed. ERR: #{result['errors']}"
    end
  end
end
