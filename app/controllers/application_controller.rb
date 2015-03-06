class ApplicationController < ActionController::Base

  include SessionsHelper
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    if params[:locale]
      session[:locale] = params[:locale]
    else
      session[:locale] ||= I18n.default_locale
    end
    I18n.locale = session[:locale]
  end

end
