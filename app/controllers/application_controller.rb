class ApplicationController < ActionController::Base
  before_action :authorize, :set_i18n_locale_from_params
  protect_from_forgery with: :exception

  protected

  def authorize
    return if session[:user_id] == '0' && User.count.zero?
    redirect_to(login_url, notice: 'Please log in') unless User.find_by(id: session[:user_id])
  end

  def set_i18n_locale_from_params
    return unless params[:locale]
    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
    else
      flash.now[:notice] = "#{params[:locale]} translation not available"
      logger.error flash.now[:notice]
    end
  end
end
