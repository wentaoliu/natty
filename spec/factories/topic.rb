FactoryGirl.define do
  factory :topic do
    association :user, factory: :admin

    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs.join('\n') }

    factory :invalid_topic do
      title nil
    end
  end
end
