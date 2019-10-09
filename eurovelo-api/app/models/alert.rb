class Alert < ApplicationRecord
  resourcify
  belongs_to :user
  belongs_to :region
  has_many :pictures, -> { order 'id' }, as: :picturable, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :pictures, allow_destroy: true

  validates_length_of :description, maximum: 300
  validates :name, :user_id, :region_id, :longitude, :latitude, :time_from, :time_to, presence: true
  validate :has_main_picture

  before_validation :add_user_region
  before_save :correct_urc_time

  ransack_alias :all, :name_or_region_name_or_region_country_name_or_user_first_name_or_user_last_name_or_description_or_addresses_city_or_user_roles

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    all_alerts = (spreadsheet.last_row-1)
    x = 0
    wrong_rows = []
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      alert = find_by(name: row["name"]) || new
      
      row.delete("lp")

      unless row["region_name"].blank?
        region = Region.find_by(name: row["region_name"])
        row["region_id"] = region.id if !region.nil?
      end
      row.delete("region_name")

      unless row["owner"].blank?
        fullname = row["owner"].split
        user = User.find_by(first_name: fullname[0], last_name: fullname[1]) if fullname.size >= 2      
        row["user_id"] = user.id if !user.nil?
      end      
      row.delete("owner")
      
      unless row["latitude"].blank?
        row["latitude"] = row["latitude"].to_s.gsub(/\,/,".")
      end
      
      unless row["longitude"].blank?
        row["longitude"] = row["longitude"].to_s.gsub(/\,/,".")
      end

      if !row["pictures"].blank?
        picture_links = row["pictures"].split(',')
        row["pictures_attributes"] = []
        picture_links.each do |link|
          object = {source: URI.parse(link.gsub(/\s+/, ""))}
          row["pictures_attributes"].push(object)
        end
        row["pictures_attributes"].first[:main] = true
      end
      row.delete("pictures")

      row["addresses_attributes"] = [
        city: row["address_city"]
      ]
      row = row.except("address_city")

      alert.attributes = row.to_hash
      if alert.save
        x += 1
      else
        wrong_rows.push(i-1)
      end
    end
    return {updated: x, updated_total: "#{x}/#{all_alerts}", wrong_rows: wrong_rows}
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
    errors.add(:alert, "Should have main picture")    
  end
  
  def correct_urc_time
    self.time_from = self.time_from + 5.hours
    self.time_to = self.time_to + 5.hours
  end
end
