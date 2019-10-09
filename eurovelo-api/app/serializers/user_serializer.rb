class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone, :email, :company, :role, :region_id, :created_at, :country, :accept_terms
  has_many :roles
  belongs_to :region
  belongs_to :parent
  has_many :children
  
  def country
    object.region.country
  end
end