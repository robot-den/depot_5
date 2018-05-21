class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception

  protected

  def authorize
    redirect_to(login_url, notice: 'Please log in') unless User.find_by(id: session[:user_id])    
  end
end
