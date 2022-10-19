# frozen_string_literal: true

class UsersList < ::Introspec::BaseQuery
  type [::Types::User], null: true

  def resolve
    Users.all
  end
end
