class PictureSerializer < ActiveModel::Serializer
  attributes :id, :source, :main
  
  def source
    "http://158.69.210.11:8100" + object.source.to_s
  end
end
