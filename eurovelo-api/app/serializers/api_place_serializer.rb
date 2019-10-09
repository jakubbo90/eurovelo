class ApiPlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :short_desc, :long_desc, :latitude, :longitude, :region_name, :main_category, :sub_category, :country_name, :sub_sub_category, :created_at, :updated_at, :place_category, :region_id, :author
  belongs_to :main_category
  has_many :addresses
  has_many :videos
  has_many :pictures
  has_many :attachments
  has_many :identities
  
  def main_category
    mc.parent.parent ? mc.parent.parent.name : mc.parent.name
  end
  
  def sub_category
    mc.parent.parent ? mc.parent.name : mc.name
  end
  
  def region_name
    object.region.name
  end
  
  def country_name
    object.region.country.name
  end
  
  def sub_sub_category
    mc.parent.parent ? mc.name : nil
  end
  
  def place_categorys
    object.place_category.try(:category).try(:name)
  end
  
  private
  def mc
    object.main_category
  end
end
