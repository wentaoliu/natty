FactoryGirl.define do
  factory :meeting do
    association :user, factory: :admin

    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs.join('\n') }

    factory :invalid_meeting do
      title nil
    end
  end
end
