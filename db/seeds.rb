User.create!(
  username: 'admin',
  name: 'Administrator',
  password: 'password',
  password_confirmation: 'password',
  admin: true,
  state: 1,
  email: 'admin@rtiss.org'
)
