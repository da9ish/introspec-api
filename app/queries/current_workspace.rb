# frozen_string_literal: true

class CurrentWorkspace < Introspec::BaseQuery
  type ::Types::Workspace, null: true

  def resolve
    user = User.find(context[:current_resource][:id])
    user.workspace
  end
end
