class TrailSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :short_desc, :long_desc, :distance, :created_at, :updated_at, :trail_category_main, :country, :region_id, :author
  belongs_to :user
  has_many :pictures
  has_many :videos
  has_many :attachments
  has_many :places
  has_many :trail_places
  belongs_to :trail_category
  belongs_to :region
  
  def trail_category_main
    object.trail_category&.parent&.id
  end
  
  def country
    object.region.country
  end
end
