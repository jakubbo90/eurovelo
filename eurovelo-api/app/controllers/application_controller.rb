class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions
  include ActionController::MimeResponds
  
  rescue_from CanCan::AccessDenied do |exception|
    render json: {error: 'You are not authorized to see this page'}, status: :forbidden, content_type: 'text/html'
  end
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:authorizer_id, :first_name, :last_name, :phone, :email, :company ])
  end
end
