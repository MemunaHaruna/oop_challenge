require 'csv'

class CsvParser
  def parse(file)
    CSV.foreach(file.path, headers: true) do |row|
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

      # TO-DO:
      # - gender must be between male, female, other??
      # - job classification should be between White collar, Blue Collar, Other ??
      # - should customer_id be unique??
      process(user: user)

    end
  end

  private
    attr_reader :file

    def process(user:)
      ImportUsersJob.perform_later(user)
    end
end
