class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :source, :source_file_name
  
  def source
    "http://158.69.210.11:8100" + object.source.to_s
  end
end
