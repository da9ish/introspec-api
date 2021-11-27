# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :auth
  end

  private

  def auth
    # Current.user = current_user
  end
end
