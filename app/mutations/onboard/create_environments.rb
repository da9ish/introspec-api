# frozen_string_literal: true

module Onboard
  class CreateEnvironments < ::Introspec::BaseMutation
    argument :environments, [::Types::EnvironmentsInput], required: true

    type [::Types::Environment], null: true

    def resolve(environments:)
      @environments = environments
      create_environments
    end

    def create_environments
      @environments.each do |env|
        Environment.create!(workspace: Current.workspace, name: env[:name], identifier: env[:identifier]) unless Environment.exists?(identifier: env[:identifier])
      end
      Environment.where(workspace: Current.workspace)
    end

    def user
      @user ||= User.find(Current.user.id)
    end
  end
end
