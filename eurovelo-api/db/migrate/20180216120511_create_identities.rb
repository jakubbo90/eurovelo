class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.string :link
      t.string :provider
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
