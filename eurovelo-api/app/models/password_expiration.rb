class PasswordExpiration < ApplicationRecord
  validates :expiration_date, :period_in_days, presence: true
  validates :period_in_days, inclusion: { in: 1..365, message: "Number of days should be between 1 and 365" }
  def self.reset_all_passwords
    last_expiration = PasswordExpiration.last
    if last_expiration.expiration_date.to_date == Date.today
      users = User.joins(:roles).where.not(roles: {name: "super_admin"})
      users.each do |user|
        # Generate random, long password that the user will never know:
        new_password = Devise.friendly_token(50) + "R$"
        user.password = new_password
        user.password_confirmation = new_password
        user.skip_email = true
        user.save

        # Send instructions so user can enter a new password:
        user.send_reset_password_instructions
      end
      PasswordExpiration.create(expiration_date: last_expiration.expiration_date + last_expiration.period_in_days.days, period_in_days: last_expiration.period_in_days)
    end
  end
  
  # def self.reset_expired_passwords
  #   users = User.joins(:roles).where.not(roles: {name: "super_admin"})
  #   users.each do |user|
  #     if user.password_created_at.to_date + PasswordExpiration.last.period_in_days.days <= Date.today
  #       # Generate random, long password that the user will never know:
  #       new_password = Devise.friendly_token(50)
  #       user.reset_password(new_password, new_password)
  # 
  #       # Send instructions so user can enter a new password:
  #       user.send_reset_password_instructions
  #     end
  #   end
  # end
end
