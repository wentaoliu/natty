module LoginMacros
  def sign_in
    user = create(:user)
    cookies[:remember_token] = 'my_remember_token'
    user.update_attribute(:remember_token, User.digest('my_remember_token'))
  end
end
