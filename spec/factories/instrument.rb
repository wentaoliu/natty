FactoryGirl.define do
  factory :instrument do
    association :user, factory: :admin

    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs.join('\n') }

    factory :invalid_instrument do
      title nil
    end
  end
end
