class ProcessMailchimpResponseJob < ApplicationJob
  queue_as :default

  def perform(user)
    User.update_status(JSON.parse(user))
  rescue => error
    Rails.logger.error(error)
  end
end
