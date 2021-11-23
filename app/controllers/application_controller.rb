# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ::Authentication

  before_action :authenticate_user!
end
