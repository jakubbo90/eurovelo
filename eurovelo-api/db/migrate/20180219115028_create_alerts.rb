class CreateAlerts < ActiveRecord::Migration[5.1]
  def change
    create_table :alerts do |t|
      t.references :user, foreign_key: true
      t.references :region, foreign_key: true
      t.string :name
      t.string :description
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.date :time_from
      t.date :time_to
      
      t.timestamps
    end
  end
end
