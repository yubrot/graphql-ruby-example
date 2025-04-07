# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    operation_name = params[:operationName]
    context = { current_user: }
    query = GraphQL::Query.new(Gre::Schema, params[:query], variables:, operation_name:, context:)
    result = ActiveRecord::Base.connected_to(role: query.mutation? ? :writing : :reading) do
      GraphQL::Execution::Interpreter.run_all(query.schema, [query])[0]
    end
    render json: result
  rescue StandardError => e
    return handle_error_in_local(e) if Rails.env.local?

    raise
  end

  private

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

  def handle_error_in_local(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: :internal_server_error
  end
end
