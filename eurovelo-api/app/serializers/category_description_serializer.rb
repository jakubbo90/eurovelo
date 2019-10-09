class CategoryDescriptionSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :title, :short_desc, :long_desc, :name
  belongs_to :user
  has_many :pictures
  has_many :videos
end
