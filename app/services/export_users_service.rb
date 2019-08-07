require 'csv'

class ExportUsersService
  def self.call(email)
    generate_users_csv
    UserMailer.export(recipient: email).deliver_later
  end

  private

  def self.generate_users_csv
    users = User.pluck(:first_name, :last_name, :customer_id, :age, :gender,
      :region, :job_classification, :date_joined, :balance, :status)
    path = Rails.root.join('P1-UK-Bank-Customers-update.csv')
    CSV.open(path, "w") do |csv|
      csv << csv_header
      users.each do |user|
        csv << user
      end
    end
  end

  def self.csv_header
    [
      "Name", "Surname", "CustomerID", "Age", "Gender", "Region",
      "Job Classification", "Date Joined", "Balance", "Status"
    ]
  end
end
