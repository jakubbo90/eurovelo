class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :level, :type
  has_many :children
  belongs_to :parent
end
