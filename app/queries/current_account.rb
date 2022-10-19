# frozen_string_literal: true

class CurrentAccount < ::Introspec::BaseQuery
  type ::Types::User, null: true

  def resolve
    if context[:current_resource]
      Rails.logger.info "Authenticated user on public field: #{context[:current_resource].email}"
      User.find(context[:current_resource].id)
    else
      Rails.logger.info "Field does not require authentication"
    end
  end
end
