FactoryGirl.define do
  factory :order do
    association :user, factory: :admin

    title { Faker::Lorem.sentence }

    factory :invalid_order do
      title nil
    end
  end
end
