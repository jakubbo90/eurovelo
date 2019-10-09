class CreateTrailPlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :trail_places do |t|
      t.references :trail, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
