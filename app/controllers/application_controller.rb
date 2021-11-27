# frozen_string_literal: true

class ApplicationController < ActionController::API
  include GraphqlDevise::Concerns::SetUserByToken

  # include ::Authentication

  # before_action :authenticate_user!
end
