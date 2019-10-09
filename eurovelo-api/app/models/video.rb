class Video < ApplicationRecord
  belongs_to :videoable, polymorphic: true, optional: true
  
  after_save :check_duplication
  
  def check_duplication
    if Video.where(link: self.link, videoable_type: self.videoable_type, videoable_id: self.videoable_id).count > 1
      self.destroy
    end
  end
end
