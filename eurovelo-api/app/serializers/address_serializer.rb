class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :street_number, :city, :postcode, :phone, :cellphone, :email, :link, :addressable_id, :addressable_type
end
