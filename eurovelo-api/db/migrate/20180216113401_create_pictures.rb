class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.references :picturable, polymorphic: true, index: true
      t.attachment :source

      t.timestamps
    end
  end
end
