FactoryGirl.define do
  factory :inventory do
    association :user, factory: :admin

    item_name { Faker::Lorem.sentence }

    factory :invalid_inventory do
      item_name nil
    end
  end
end
