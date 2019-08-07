module ExceptionHandler
  extend ActiveSupport::Concern

  class InvalidRequest < StandardError; end
  class InvalidToken < StandardError; end
  class MissingToken < StandardError; end
  class InvalidFileFormat < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ExceptionHandler::InvalidRequest, with: :record_invalid
    rescue_from ExceptionHandler::InvalidToken, with: :record_invalid
    rescue_from ExceptionHandler::MissingToken, with: :record_invalid
    rescue_from ExceptionHandler::InvalidFileFormat, with: :record_invalid
  end

  def record_invalid(error)
    Rails.logger.error(error)
    json_error_response(status: :unprocessable_entity, message: error.message, errors: error)
  end
end
