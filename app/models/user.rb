class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :customer_id, :age, :gender,
                        :region, :job_classification, :date_joined, :balance

  validates_uniqueness_of :customer_id

  def self.update_status(result)
    user = find_by(customer_id: result['customer_id'])
    status = 'subscribed' if (result['status'] && result['status'] == 'Success')
    if user && status
      user.update(status: status)
    end
  end
end
