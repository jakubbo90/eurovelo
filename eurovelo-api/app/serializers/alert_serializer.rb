class AlertSerializer < ActiveModel::Serializer
  attributes :id, :name, :time_from, :time_to, :description, :latitude, :longitude, :created_at, :updated_at, :country, :region_id, :author
  belongs_to :user
  belongs_to :region
  has_many :pictures
  has_many :addresses
  
  def country
    object.region.country
  end
end
