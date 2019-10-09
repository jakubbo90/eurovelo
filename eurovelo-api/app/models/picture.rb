class Picture < ApplicationRecord
  has_attached_file :source
  
  belongs_to :picaturable, polymorphic: true, optional: true
  
  validates_with AttachmentSizeValidator, attributes: :source, less_than: 5.megabytes
  validates_attachment_content_type :source, content_type: /\Aimage/
  
  before_save :change_main
  after_save :check_duplication
  
  def check_duplication
    if Picture.where(source_file_name: self.source_file_name, source_file_size: self.source_file_size, picturable_type: self.picturable_type, picturable_id: self.picturable_id).count > 1
      self.destroy
    end
  end
  
  def change_main
    if self.main == true
      self.picturable_type.constantize.find(self.picturable_id).pictures.update_all(main: false)
    end
  end
end
