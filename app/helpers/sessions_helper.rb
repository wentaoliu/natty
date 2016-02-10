module SessionsHelper
  # Sign In and Sign out
  def sign_in(user, permanent = false)
    remember_token = user.generate_remember_token!
    if permanent
      cookies.permanent[:remember_token] = remember_token
    else
      cookies[:remember_token] = remember_token
    end
    self.current_user = user
    return remember_token
  end

  def sign_out
    current_user.generate_remember_token!
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # Get and set the current user
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
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

  def require_signin
    redirect_to signin_path unless signed_in?
  end

end
