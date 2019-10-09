class TrailPlace < ApplicationRecord
  belongs_to :place
  belongs_to :trail
  
  after_save :check_duplication
  
  def check_duplication
    if TrailPlace.where(place_id: self.place_id, trail_id: self.trail_id).count > 1
      self.destroy
    end
  end
end
