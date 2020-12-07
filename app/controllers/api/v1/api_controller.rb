module Api
  module V1
    class ApiController < ApplicationController
      include Api::Concerns::ActAsApiRequest
      include DeviseTokenAuth::Concerns::SetUserByToken

      helper_method :current_user

      layout false
      respond_to :json

      rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
      rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing
      rescue_from VenmoError,                          with: :render_venmo_error

      def status
        render json: { online: true }
      end

      private

      def current_user
        @current_user ||= User.find(params[:id] || params[:user_id])
      end

      def render_not_found(exception)
        logger.info { exception } # for logging
        render json: {error: exception.message}, status: :not_found
      end

      def render_record_invalid(exception)
        logger.info { exception } # for logging
        render json: { errors: exception.record.errors.as_json }, status: :bad_request
      end

      def render_parameter_missing(exception)
        logger.info { exception } # for logging
        render json: { error: I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
      end

      def render_venmo_error(exception)
        logger.info { exception }
        render json: { errors: exception.message }, status: :bad_request
      end
    end
  end
end
