# frozen_string_literal: true

class SchemaController < ApplicationController
  include GraphqlDevise::SetUserByToken
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  before_action -> { set_resource_by_token(User) }

  def execute
    query = params[:query]
    result = WorkspaceApiSchema.execute(query, **execute_params(params))
    render json: result unless performed?
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  def execute_params(item)
    {
      operation_name: item[:operationName],
      variables:      prepare_variables(item[:variables]),
      context:        {
        headers: request.headers,
        **gql_devise_context(User)
      }
    }
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(err)
    logger.error err.message
    logger.error err.backtrace.join("\n")

    render json: { errors: [{ message: err.message, backtrace: err.backtrace }], data: {} }, status: :internal_server_error
  end
end
