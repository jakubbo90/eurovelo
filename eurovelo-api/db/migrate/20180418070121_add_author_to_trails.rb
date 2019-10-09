class AddAuthorToTrails < ActiveRecord::Migration[5.1]
  def change
    add_column :trails, :author, :string
  end
end
