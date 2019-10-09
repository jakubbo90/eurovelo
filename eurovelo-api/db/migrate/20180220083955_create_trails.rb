class CreateTrails < ActiveRecord::Migration[5.1]
  def change
    create_table :trails do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :short_desc
      t.string :long_desc
      t.decimal :distance, precision: 8, scale: 2 

      t.timestamps
    end
  end
end
