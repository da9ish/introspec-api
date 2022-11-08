# frozen_string_literal: true

module Types
  class User < Types::BaseObject
    field :email, String, null: false
    field :username, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :role, ::Types::RoleEnum, null: false
    field :profile_pic, String, null: true
    field :workspace, ::Types::Workspace, null: true

    field :name, String, null: false

    def name
      "#{object[:first_name]} #{object[:last_name]}"
    end
  end
end
