class PlaceShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :short_desc, :long_desc, :latitude, :longitude, :region_name, :main_category, :sub_category, :country_name, :sub_sub_category, :created_at, :updated_at, :author
  belongs_to :main_category
  belongs_to :user
  has_many :addresses
  has_many :videos
  has_many :pictures
  has_many :attachments
  has_many :identities
  
  def main_category
    category = if mc.parent.parent then mc.parent.parent else mc.parent end
    name = category.name
    id = category.id
    return {name: name, id: id}
  end
  
  def sub_category
    category = if mc.parent.parent then mc.parent else mc end
    name = category.name
    id = category.id
    return {name: name, id: id}
  end
  
  def region_name
    region = object.region
    name = region.name
    id = region.id
    return {name: name, id: id}
  end
  
  def country_name
    country = object.region.country
    name = country.name
    id = country.id
    return {name: name, id: id}
  end
  
  def sub_sub_category
    category = if mc.parent.parent then mc else nil end
    name = category&.name
    id = category&.id
    return {name: name, id: id}
  end
  
  private
  def mc
    object.main_category
  end
end
