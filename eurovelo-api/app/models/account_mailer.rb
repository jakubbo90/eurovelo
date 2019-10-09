class AccountMailer < Devise::Mailer   
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
  
  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Confirmation account instruction"
    opts[:from] = 'no-reply@mailer.com'
    super
  end
end