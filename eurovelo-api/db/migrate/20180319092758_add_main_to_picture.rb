class AddMainToPicture < ActiveRecord::Migration[5.1]
  def change
    add_column :pictures, :main, :boolean
  end
end
