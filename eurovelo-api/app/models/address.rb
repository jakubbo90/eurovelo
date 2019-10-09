class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, optional: true
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_blank: true, if: :place_address?
  validates :street, :street_number, presence: true, if: :place_address?
  validates :city, presence: true
  
  def place_address?
    self.addressable_type == "Place"
  end
end
