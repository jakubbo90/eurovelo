class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :short_desc
      t.text :long_desc
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      
      t.references :region, index: true
      t.references :category, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
