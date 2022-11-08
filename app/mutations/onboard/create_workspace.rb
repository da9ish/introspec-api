# frozen_string_literal: true

module Onboard
  class CreateWorkspace < ::Introspec::BaseMutation
    argument :name, String, required: true
    argument :identifier, String, required: true
    argument :logo, String, required: true

    type ::Types::Workspace, null: true

    def resolve(name:, identifier:, logo:)
      @name = name
      @identifier = identifier
      @logo = logo
      create_workspace
    end

    def create_workspace
      workspace = Workspace.create!(name: @name, identifier: @identifier, logo: @logo)
      Environment.create!(workspace: workspace, name: "Live", identifier: "live") unless Environment.exists?(workspace: @identifier, identifier: "live")
      user.update!(workspace: workspace)

      workspace
    end

    def update_user(workspace); end

    def user
      @user ||= User.find(Current.user.id)
    end
  end
end
