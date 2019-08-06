class AddValidations < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :customer_id, unique: true
  end
end
