class Trail < ApplicationRecord
  belongs_to :user
  belongs_to :trail_category, foreign_key: :category_id, optional: :true
  belongs_to :region
  has_many :pictures, -> { order 'id' }, as: :picturable, dependent: :destroy
  has_many :videos, as: :videoable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :trail_places, dependent: :destroy
  has_many :places, through: :trail_places

  accepts_nested_attributes_for :pictures, allow_destroy: true
  accepts_nested_attributes_for :videos, allow_destroy: true
  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :trail_places, allow_destroy: true

  validates_length_of :short_desc, maximum: 300
  validates :name, :short_desc, :long_desc, :category_id, :user_id, :region_id, :distance, presence: true
  validate :has_main_picture

  before_validation :add_user_region

  ransack_alias :all, :name_or_trail_category_name_or_trail_category_parent_name_or_region_name_or_region_country_name_or_user_first_name_or_user_last_name_or_short_desc_or_long_desc_or_user_roles_or_trail_places

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    all_trails = (spreadsheet.last_row-1)
    x = 0
    wrong_rows = []
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      trail = find_by(name: row["name"]) || new
      
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

      unless row["category"].blank?
        category = TrailCategory.find_by(name: row["category"])
        row["category_id"] = category.id if !category.nil?
      end
      row.delete("category")
      
      unless row["distance"].blank?
        row["distance"] = row["distance"].to_s.gsub(/\,/,".")
      end

      row["videos_attributes"] = [link: row["video_link"]]
      row.delete("video_link")

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

      trail.attributes = row.to_hash
      if trail.save
        x += 1
      else
        wrong_rows.push(i-1)
      end
    end
    return {updated: x, updated_total: "#{x}/#{all_trails}", wrong_rows: wrong_rows}
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
    errors.add(:trail, "Should have main picture")    
  end
end
