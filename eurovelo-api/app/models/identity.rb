class Identity < ApplicationRecord
  belongs_to :place
  
  after_save :check_duplication
  
  def check_duplication
    if Identity.where(place_id: self.place_id, link: self.link).count > 1
      self.destroy
    end
  end
end
