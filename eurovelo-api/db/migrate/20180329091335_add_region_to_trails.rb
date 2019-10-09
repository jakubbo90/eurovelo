class AddRegionToTrails < ActiveRecord::Migration[5.1]
  def change
    add_reference :trails, :region, foreign_key: true
  end
end
