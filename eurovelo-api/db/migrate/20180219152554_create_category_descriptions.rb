class CreateCategoryDescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :category_descriptions do |t|
      t.references :user
      t.string :title
      t.string :short_desc
      t.text :long_desc
      
      t.timestamps
    end
  end
end
