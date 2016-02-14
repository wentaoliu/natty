module LoginSupport

  def sign_in
    user = create(:admin)
    cookies[:remember_token] = 'my_remember_token'
    user.update_attribute(:remember_token, User.digest('my_remember_token'))
  end

  def access_token
    application = create(:application) # OAuth application
    current_user = create(:admin)
    token = create(:access_token, application: application, resource_owner_id: current_user.id)
    token.token
  end

end
