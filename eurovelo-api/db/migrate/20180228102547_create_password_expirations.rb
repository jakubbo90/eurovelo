class CreatePasswordExpirations < ActiveRecord::Migration[5.1]
  def change
    create_table :password_expirations do |t|
      t.datetime :expiration_date
      t.integer :period_in_days

      t.timestamps
    end
  end
end
