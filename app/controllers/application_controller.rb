# frozen_string_literal: true

class ApplicationController < ActionController::API
  helper_method :require_subdomain

  private

  def require_subdomain
    not_found unless subdomain_exist?
  end

  def subdomain_exist?
    workspace = Workspace.find_by(identifier: request.subdomain)
    workspace.nil? || Subdomain::STATIC_SUB_DOMAINS.include?(require_subdomain)
  end

  def not_found
    raise ActionController::RoutingError.new("404"), "Workspace not found"
  end
end
