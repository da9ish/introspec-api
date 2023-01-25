# frozen_string_literal: true

require "test_helper"

class CreateWorkspaceJobTest < ActiveJob::TestCase
  test "creates rds instance" do
    Current.test do
      # CreateWorkspaceJob.perform_now workspaces(:spacex)
    end
  end
end
