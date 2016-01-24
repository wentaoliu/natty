FactoryGirl.define do
  factory :schedule do
    association :user, factory: :admin

    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs.join('\n') }

    factory :invalid_schedule do
      title nil
    end
  end
end
