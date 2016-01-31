module SessionsHelper
  # Sign In and Sign out
  def sign_in(user, permanent = false)
    self.current_user = user

    case request.format
    when Mime::HTML
      remember_token = user.generate_remember_token!
      if permanent
        cookies.permanent[:remember_token] = remember_token
      else
        cookies[:remember_token] = remember_token
      end
      return remember_token
    else # Mime::JSON ...
      return user.generate_api_token!
    end
  end

  def sign_out
    case request.format
    when Mime::HTML
      current_user.generate_remember_token!
      cookies.delete(:remember_token)
    else # Mime::JSON ...
      user.generate_api_token!
    end
    self.current_user = nil
  end

  # Get and set the current user
  def current_user
    case request.format
    when Mime::HTML
      remember_token = User.digest(cookies[:remember_token])
      @current_user ||= User.where(remember_token: remember_token).first
    else # Mime::JSON ...
      api_token = User.digest(request.headers["Authorization"] || params[:token])
      @current_user ||= User.where(api_token: api_token).first
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
