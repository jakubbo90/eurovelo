class IdentitySerializer < ActiveModel::Serializer
  attributes :id, :link, :provider, :place_id
end
