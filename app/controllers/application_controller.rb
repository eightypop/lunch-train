class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
    @lines = Line.all
  end

  def is_cibot?
    (request.format == Mime::JSON) &&
        request.headers.include?('HTTP_USER_AGENT') &&
        request.headers['HTTP_USER_AGENT'].include?('Hubot')
  end

  def api_auth_rider!

    we_ok = request.headers.include?('HTTP_X_AUTH') && request.headers['HTTP_X_AUTH'].include?('customink.com')
    return false unless we_ok
    email_address = request.headers['HTTP_X_AUTH']

    rider = Rider.where(email: email_address).first || Rider.create(email: email_address, name: email_address[/[^@]+/])

    sign_in rider

  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

end
