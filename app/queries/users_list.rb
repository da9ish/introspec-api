# frozen_string_literal: true

class UsersList < ::Introspec::BaseQuery
  type [::Types::User], null: true

  def resolve
    User.all
  end
end
