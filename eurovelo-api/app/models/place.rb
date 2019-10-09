class Place < ApplicationRecord
  require 'net/http'
  require 'resolv-replace'
  
  resourcify
  belongs_to :user
  belongs_to :main_category, foreign_key: :category_id
  belongs_to :region, foreign_key: :region_id
  
  has_many :pictures, -> { order 'id' }, as: :picturable, dependent: :destroy
  has_many :videos, as: :videoable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :trail_places, dependent: :destroy
  has_many :trails, through: :trail_places
  has_one :place_category, dependent: :destroy
  
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :pictures, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true
  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :identities, allow_destroy: true
  
  validates_length_of :short_desc, maximum: 300
  validates :name, :short_desc, :long_desc, :category_id, :user_id, :region_id, :longitude, :latitude, presence: true
  validate :has_main_picture
  
  before_validation :add_user_region
  after_save :add_place_category
  
  ransack_alias :all, :name_or_main_category_name_or_main_category_parent_name_or_main_category_parent_parent_name_or_region_name_or_region_country_name_or_user_first_name_or_user_last_name_or_short_desc_or_long_desc_or_addresses_street_or_addresses_street_number_or_addresses_city_or_addresses_postcode_or_addresses_phone_or_addresses_cellphone_or_addresses_email_or_addresses_link_or_place_category_category_name_or_user_roles
  ransack_alias :on_main, :main_category_parent_parent_id_or_main_category_parent_id
  ransack_alias :on_submain, :main_category_parent_id_or_main_category_id
  ransack_alias :on_subsubmain, :main_category_id
  
  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    all_places = (spreadsheet.last_row-1)
    x = 0
    wrong_rows = []
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      place = find_by(name: row["name"]) || new
      
      row.delete("lp")
      
      unless row["region_name"].blank?
        region = Region.find_by(name: row["region_name"])
        row["region_id"] = region.id if !region.nil?
      end
      row.delete("region_name")
      
      unless row["owner"].blank?
        fullname = row["owner"].split(" ")
        user = User.where('lower(first_name) = ? AND lower(last_name) = ?', fullname[0].downcase, fullname[1].downcase).first if fullname.size >= 2
        row["user_id"] = user.id if !user.nil?
      end      
      row.delete("owner")
      
      unless row["category"].blank?
        category = MainCategory.find_by(name: row["category"].strip)      
        row["category_id"] = category.id if !category.nil?
      end      
      row.delete("category")
      
      unless row["latitude"].blank?
        row["latitude"] = row["latitude"].to_s.gsub(/\,/,".")
      end
      
      unless row["longitude"].blank?
        row["longitude"] = row["longitude"].to_s.gsub(/\,/,".")
      end
      
      row["identities_attributes"] = [link: row["social_media_link"], provider: row["social_media_provider"]]
      row = row.except("social_media_link", "social_media_provider")
      
      row["videos_attributes"] = [link: row["video_link"]]
      row.delete("video_link")
      
      if !row["pictures"].blank?
        picture_links = row["pictures"].split(',')
        row["pictures_attributes"] = []
        picture_links.each do |link|
          break if !Place.uri?(link)
          break if !Place.remote_image_exists?(link)
          object = {source: URI.parse(link.gsub(/\s+/, ""))}
          row["pictures_attributes"].push(object)
        end
        row["pictures_attributes"].first[:main] = true unless row["pictures_attributes"].blank?
      end
      row.delete("pictures")
      
      row["addresses_attributes"] = [
        street: row["address_street"],
        street_number: row["address_street_number"],
        city: row["address_city"],
        postcode: row["address_postcode"],
        phone: row["address_phone"],
        cellphone: row["address_cellphone"],
        email: row["address_email"],
        link: row["address_link"]
      ]
      row = row.except("address_street", "address_street_number", "address_city", "address_postcode", "address_phone", "address_cellphone", "address_email", "address_link")
      
      place.attributes = row.to_hash
      if place.save
        x += 1
      else
        wrong_rows.push(i-1)
      end
    end
    return {updated: x, updated_total: "#{x}/#{all_places}", wrong_rows: wrong_rows}
  end
  
  def self.remote_image_exists?(url)
    url = URI.parse(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")

    http.start do |http|
      return http.head(url.request_uri)['Content-Type'].start_with? 'image'
    end
  end
  
  def self.uri?(string)
    uri = URI.parse(string)
    %w( http https ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end 
  
  def add_place_category
    if self.main_category.parent.parent.nil?
      category_id = MainCategory.find(self.category_id).parent.id
    else
      category_id = MainCategory.find(self.category_id).parent.parent.id
    end
    PlaceCategory.find_or_create_by(place_id: self.id, category_id: category_id)
  end
  
  def add_user_region
    if self.user_id
      user = User.find(self.user_id)
      self.region = user.region unless user.superadmin?
    end
  end
  
  def has_main_picture
    self.pictures.each do |image|
      if image.main == true && !image._destroy
        return true
      end
    end
    errors.add(:object, "Should have main picture")    
  end
end
