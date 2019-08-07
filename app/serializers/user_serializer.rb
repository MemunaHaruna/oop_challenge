class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :customer_id, :age, :gender,
  :region, :job_classification, :date_joined, :balance
end
