# frozen_string_literal: true

class CurrentAccount < ::Introspec::BaseQuery
  type ::Types::User, null: true

  def resolve
    if context[:current_resource]
      Rails.logger.info "Authenticated user on public field: #{context[:current_resource].email}"
      context[:current_resource]
    else
      Rails.logger.info "Field does not require authentication"
    end
  end
end
