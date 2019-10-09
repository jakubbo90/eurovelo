class AddAcceptTermsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :accept_terms, :boolean
  end
end
