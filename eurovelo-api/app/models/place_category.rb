class PlaceCategory < ApplicationRecord
  belongs_to :place
  belongs_to :category
end
