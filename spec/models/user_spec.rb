require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validations" do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:job_classification) }
    it { should validate_presence_of(:region) }
    it { should validate_presence_of(:balance) }
    it { should validate_presence_of(:date_joined) }
  end

  describe ".update_status" do
    context "when mailchimp response is Success" do
      it "should update user status to subscribed " do

      end
    end


    context "when mailchimp response is Fail" do
      it "should not update user" do

      end
    end
  end
end
