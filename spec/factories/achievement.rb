FactoryGirl.define do
  factory :achievement do
    association :user, factory: :admin

    title { Faker::Lorem.sentence }
    author { Faker::Name.name }
    link { Faker::Internet.url }
    content { Faker::Lorem.paragraphs.join('\n') }

    factory :invalid_achievement do
      title nil
    end
  end
end
