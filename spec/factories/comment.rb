FactoryGirl.define do
  factory :comment do
    
    content { Faker::Lorem.paragraphs.join('\n') }

    factory :invalid_comment do
      title nil
    end
  end
end
