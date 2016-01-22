FactoryGirl.define do
  factory :user do
    username 'admin'
    name 'Administrator'
    password 'secret'
    password_confirmation { password }
    admin true
    state 1
    email 'admin@example.com'
  end
end
