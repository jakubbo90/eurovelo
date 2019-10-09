class AddRoleAttributeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string
    User.all.each do |user|
      user.update(role: user.roles.take.name)
    end
  end
  
end
