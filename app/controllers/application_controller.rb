class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: :format_js?

  before_action :set_locale
  before_action :store_return_to
  before_action :authenticate_user!

  def set_locale(locale = params[:locale])
    if locale
      cookies.permanent[:locale] = locale
    else
      cookies.permanent[:locale] ||= I18n.default_locale
    end
    I18n.locale = cookies.permanent[:locale]
  end

  def store_return_to
    session[:return_to] = request.url
  end

  # Permission denied
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, notice: exception.message
  end

  def format_js?
    request.format.js?
  end

end
