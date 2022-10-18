# frozen_string_literal: true

module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action do
      workspace = Workspace.find(request.headers[:workspaceId]) if request.headers[:workspaceId]
      user = User.find_by(email: request.headers[:uid]) if request.headers[:uid]
      environment = Environment.find(request.headers[:environmentId]) if request.headers[:environmentId]

      Current.workspace = workspace unless workspace.nil?
      Current.user = user unless user.nil?
      Current.environment = environment unless environment.nil?
    end
  end
end
