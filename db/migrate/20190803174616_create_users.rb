class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :customer_id, null: false
      t.integer :age, null: false
      t.string :gender, null: false
      t.string :region, null: false
      t.string :job_classification, null: false
      t.string :date_joined, null: false
      t.integer :balance, null: false
      t.string :status

      t.timestamps
    end
  end
end
