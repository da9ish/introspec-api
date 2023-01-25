# frozen_string_literal: true

class CurrentAccount < Introspec::BaseQuery
  type ::Types::User, null: true

  def resolve
    if context[:current_resource]
      user = User.find(context[:current_resource][:id])
      Rails.logger.info "Authenticated user on public field: #{context[:current_resource].email}"
      user
    else
      Rails.logger.info "Field does not require authentication"
    end
  end
end
