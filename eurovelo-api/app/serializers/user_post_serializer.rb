class UserPostSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :created_at, :updated_at
  
  def category
    object.class.name
  end
end