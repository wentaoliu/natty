FactoryGirl.define do
  factory :application, class: Doorkeeper::Application do
    name { Faker::Name.name }
    redirect_uri{ 'https://foo.bar.com' }
    uid { "uid" }
    secret { "secret" }
  end
end
