class ApplicationController < ActionController::Base
  after_filter :flash_headers

  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

   rescue_from Pundit::NotAuthorizedError do |exception|
     redirect_to root_url, alert: exception.message
   end

  def after_sign_in_path_for(resource)
    topics_path
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def flash_headers
    # This will discontinue execution if Rails detects that the request is not
    # from an AJAX request, i.e. the header wont be added for normal requests
    return unless request.xhr?
   
    # Add the appropriate flash messages to the header, add or remove as
    # needed, but I think you'll get the point
    response.headers['x-flash'] = flash[:error]  unless flash[:error].blank?
    response.headers['x-flash'] = flash[:notice]  unless flash[:notice].blank?
    response.headers['x-flash'] = flash[:warning]  unless flash[:warning].blank?
   
    # Stops the flash appearing when you next refresh the page
    flash.discard
  end
  
end