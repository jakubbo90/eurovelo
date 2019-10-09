class AddAuthorToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :author, :string
  end
end
