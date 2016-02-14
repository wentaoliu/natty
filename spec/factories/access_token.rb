FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    resource_owner_id { 'user1' }
    application
    expires_in 2.hours
  end
end
