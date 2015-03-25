class ApplicationController < ActionController::Base

  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale(locale = params[:locale])
    if locale
      cookies.permanent[:locale] = locale
    else
      cookies.permanent[:locale] ||= I18n.default_locale
    end
    I18n.locale = cookies.permanent[:locale]
  end

end
