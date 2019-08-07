class ImportUsersJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  around_perform :log_action

  def perform(user, subscription_service: nil)
    subscription_service =
      subscription_service || MailchimpService.new(user: user, url: mailchimp_users_url)
    subscription_service.process
  rescue => error
    Rails.logger.error(error)
  end

  private

    def log_action
      Rails.logger.info "Started adding user to subscription list"
      yield
      Rails.logger.info "Finished adding user to subscription list"
    end
end
