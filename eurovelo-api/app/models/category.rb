class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :children, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :trails, dependent: :destroy
  has_many :place_categories, dependent: :destroy
  
  enum level: [:main, :submain, :subsubmain]
end
