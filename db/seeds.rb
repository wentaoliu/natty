user = User.new(
  email: 'admin@example.com',
  name: 'Administrator',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)
user.skip_confirmation!
user.save!
