class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :link
      t.references :videoable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
