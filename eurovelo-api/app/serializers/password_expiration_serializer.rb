class PasswordExpirationSerializer < ActiveModel::Serializer
  attributes :id, :expiration_date, :period_in_days
end
