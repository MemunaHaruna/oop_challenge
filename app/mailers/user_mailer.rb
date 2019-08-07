class UserMailer < ApplicationMailer
  def export(recipient)
    path = Rails.root.join('P1-UK-Bank-Customers-update.csv')
    attachments['P1-UK-Bank-Customers-report.csv'] = { mime_type: 'text/csv', content: File.read(path) }

    mail to: recipient, subject: "P1-UK-Bank-Customers Report"
  end
end
