class AddAuthorToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :author, :string
  end
end
