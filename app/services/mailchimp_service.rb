require 'net/http'
require 'uri'

class MailchimpService
  def initialize(url:, user:)
    @@subscription_list ||= []
    @user = user
    @url = url
  end

  def process
    @@subscription_list << @user
    sleep 1
    make_request
  end

  private

    attr_accessor :user, :url

    def generate_response
      self.user = user.merge(status: 'Success').to_json
    end

    def make_request
      uri = URI.parse(url)

      header = { 'Content-Type': 'text/json', 'Authorization': "Bearer #{token}" }

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = generate_response

      http.request(request)
    end

    def token
      Rails.application.credentials.mailchimp_token
    end
end


