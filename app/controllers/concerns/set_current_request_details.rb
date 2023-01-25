# frozen_string_literal: true

module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action do
      workspace = Workspace.find(request.headers["workspace-id"]) unless request.headers["workspace-id"] == "null" || request.headers["workspace-id"].nil?
      # user = User.find_by(email: request.headers[:uid]) unless request.headers[:uid] == "null" || request.headers[:uid].nil?
      environment = Environment.find(request.headers["environment-id"]) unless request.headers["environment-id"] == "null" || request.headers["environment-id"].nil?

      Current.workspace = workspace unless workspace.nil?
      # Current.user = user unless user.nil?
      Current.environment = environment unless environment.nil?
    end
  end
end
