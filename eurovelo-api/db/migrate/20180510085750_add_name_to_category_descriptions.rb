class AddNameToCategoryDescriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :category_descriptions, :name, :string
  end
end
