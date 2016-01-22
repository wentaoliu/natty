FactoryGirl.define do
  factory :news do

    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraphs.join('\n') }

    factory :invalid_news do
      title nil
    end
  end
end
