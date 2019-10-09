class CreateAccountMailers < ActiveRecord::Migration[5.1]
  def change
    create_table :account_mailers do |t|

      t.timestamps
    end
  end
end
