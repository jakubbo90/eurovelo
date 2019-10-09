class AddCategoryReferencesToTrails < ActiveRecord::Migration[5.1]
  def change
    add_reference :trails, :category, foreign_key: true
  end
end
