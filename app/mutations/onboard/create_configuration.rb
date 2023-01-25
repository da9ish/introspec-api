# frozen_string_literal: true

module Onboard
  class CreateConfiguration < ::Introspec::BaseMutation
    argument :type, String, required: true
    argument :config, JSON

    # type Types::, null: true

    def resolve(type:, identifier:, logo:)
      @name = name
      @identifier = identifier
      @logo = logo
      create_workspace
    end

    def create_workspace
      workspace = Workspace.create!(name: @name, identifier: @identifier, logo: @logo)
      Environment.create!(workspace: workspace, name: "Live", identifier: "live") unless Environment.exists?(workspace: @identifier, identifier: "live")
      user.update!(workspace: workspace)
      CreateWorkspaceJob.perform_now @identifier

      workspace
    end

    def update_user(workspace); end

    def user
      @user ||= User.find(context[:current_resource].id)
    end
  end
end
