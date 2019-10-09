set :environment, "development"
every 1.day, at: '00:01 am' do
  runner "PasswordExpiration.reset_all_passwords"
end