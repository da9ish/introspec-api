class SessionsController < Devise::SessionsController
  include ActionController::MimeResponds
  before_action :configure_permitted_parameters, if: -> { action_name == "create" }
  respond_to :json

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_in, keys: %i[email password]
  end
end
