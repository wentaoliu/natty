FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Internet.password }
    password_confirmation { password }
    state 1

    factory :admin do
      admin true
    end
  end
end
