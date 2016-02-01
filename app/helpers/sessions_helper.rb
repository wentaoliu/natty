module SessionsHelper
  # Sign In and Sign out
  def sign_in_with_cookie(user, permanent = false)
    remember_token = user.generate_remember_token!
    if permanent
      cookies.permanent[:remember_token] = remember_token
    else
      cookies[:remember_token] = remember_token
    end
    self.current_user = user
    return remember_token
  end

  def sign_in_with_token(user)
    self.current_user = user
    return user.generate_api_token!
  end

  def sign_out
    if cookies[:remember_token]
      current_user.generate_remember_token!
      cookies.delete(:remember_token)
    else
      user.generate_api_token!
    end
    self.current_user = nil
  end

  # Get and set the current user
  def current_user
    # For requests from browsers
    remember_token = cookies[:remember_token]
    if remember_token
      remember_token = User.digest(remember_token)
      return @current_user ||= User.where(remember_token: remember_token).first
    end
    # For API
    api_token = request.headers["Authorization"] || params[:token]
    if api_token
      api_token = User.digest(api_token)
      return @current_user ||= User.where(api_token: api_token).first
    end
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
