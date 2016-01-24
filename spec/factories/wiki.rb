FactoryGirl.define do
  factory :wiki do
    association :user, factory: :admin

    title { Faker::Lorem.sentence }
    comment { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs.join('\n') }

    factory :invalid_wiki do
      title nil
    end
  end
end
