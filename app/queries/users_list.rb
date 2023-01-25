# frozen_string_literal: true

class UsersList < Introspec::BaseQuery
  type [::Types::User], null: true

  def resolve
    User.where(workspace_id: context[:workspace_id])
  end
end
