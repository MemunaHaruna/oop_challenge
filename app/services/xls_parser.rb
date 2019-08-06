require 'spreadsheet'
Spreadsheet.client_encoding = 'UTF-8'

class XlsParser
  def parse(file)
    sheet = Spreadsheet.open file.path
    sheet = sheet.worksheet 0
    sheet.each do |row|
      user = {
        customer_id: row[0],
        first_name: row[1],
        last_name: row[2],
        gender: row[3],
        age: row[4],
        region: row[5],
        job_classification: row[6],
        date_joined: row[7],
        balance: row[8]
      }

      process(user: user)
    end
  end

  private

  def process(user:)
    User.create! user
    ImportUsersJob.perform_later user
  end
end
