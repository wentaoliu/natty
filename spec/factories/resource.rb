FactoryGirl.define do
  factory :resource do
    association :user, factory: :admin

    title { Faker::Lorem.sentence }

    factory :invalid_resource do
      title nil
    end
  end
end
