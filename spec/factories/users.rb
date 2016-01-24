FactoryGirl.define do
  factory :user do
    username 'TestUser'
    name { Faker::Name.name }
    password { Faker::Internet.password }
    password_confirmation { password }
    state 1
    email { Faker::Internet.email }

    factory :admin do
      admin true
    end
  end
end
