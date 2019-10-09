class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :street_number
      t.string :city
      t.string :postcode
      t.string :phone
      t.string :cellphone
      t.string :email
      t.string :link
      
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
