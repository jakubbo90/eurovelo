class CategoryDescription < ApplicationRecord
  belongs_to :user
  has_many :pictures, -> { order 'created_at' }, as: :picturable, dependent: :destroy
  has_many :videos, as: :videoable, dependent: :destroy
  
  accepts_nested_attributes_for :pictures, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true
  
  validates_length_of :short_desc, maximum: 300
  validate :has_main_picture
  
  def has_main_picture
    self.pictures.each do |image|
      if image.main == true && !image._destroy
        return true
      end
    end
    errors.add(:description, "Should have main picture")    
  end
end
