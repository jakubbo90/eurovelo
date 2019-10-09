class Attachment < ApplicationRecord
  has_attached_file :source
  belongs_to :attachmentable, polymorphic: true, optional: :true
  
  validates_with AttachmentSizeValidator, attributes: :source, less_than: 50.megabytes
  do_not_validate_attachment_file_type :source
end
