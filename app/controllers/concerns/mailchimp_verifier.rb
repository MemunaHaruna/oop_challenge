class MailchimpVerifier
  attr_reader :headers

  def initialize(headers = {})
    @headers = headers
  end

  def call
    raise ExceptionHandler::InvalidToken, 'Invalid Token' unless valid_token?
  end

  def valid_token?
    http_auth_header == Rails.application.credentials.mailchimp_token
  end

  def http_auth_header
    if headers["Authorization"].present?
      return headers["Authorization"].split(" ").last
    end

    raise ExceptionHandler::MissingToken, 'Missing Token'
  end
end
