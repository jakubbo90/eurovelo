class AddPasswordCreatedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_created_at, :datetime
  end
end
