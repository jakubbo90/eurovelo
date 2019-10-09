class Region < ApplicationRecord
  belongs_to :country
  
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :trails, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :users
end
