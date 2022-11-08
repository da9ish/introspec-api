# frozen_string_literal: true

module Types
  class RoleEnum < ::Types::BaseEnum
    value "WORKSPACE_OWNER"
    value "WORKSPACE_MEMBER"
    value "WORKSPACE_USER"
    value "BOT"
  end
end
