# frozen_string_literal: true

require "test_helper"

class WorkspaceTest < ActiveSupport::TestCase
  %i[introspec].each do |workspace|
    test "workspaces(:#{workspace}) is valid" do
      model = workspaces(workspace)
      assert model.valid?, "Expected workspaces(:#{workspace}) to be valid, got errors: #{model.errors.full_messages.to_sentence}"
    end
  end
end
