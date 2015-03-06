module SessionsHelper
  # Sign In and Sign out
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end
  def sign_out
    current_user.update_attribute(:remember_token,
      User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  # Get and set the current user
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.where(remember_token: remember_token).first
  end
  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end
  def signed_in?
    !current_user.nil?
  end
  def is_visitor?
    current_user.state == 1
  end
  def is_admin?
    signed_in? and current_user.admin
  end
  def require_signin
    redirect_to signin_path unless signed_in?
  end
  def require_admin
    redirect_to root_path unless is_admin?
  end
  def format_json?
    request.format.json?
  end
end
