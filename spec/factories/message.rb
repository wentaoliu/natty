FactoryGirl.define do
  factory :message do
    association :user, factory: :admin

    content { Faker::Lorem.sentence }

    factory :invalid_message do
      content nil
    end
  end
end
