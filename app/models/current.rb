# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user, :workspace, :environment

  def test(user: nil, workspace: nil, environment: nil)
    self.user = user || User.introspec_bot
    self.workspace = workspace || "introspec_test"
    self.environment = environment || "test"

    yield
  end
end
