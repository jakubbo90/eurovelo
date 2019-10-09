class UserMailer < ApplicationMailer
  def send_reset_password_info(user)
    @password_expiration = PasswordExpiration.last
    mail to: user.email, subject: "Your password has been created successfully", from: "michal@hand2band.media"
  end
end
