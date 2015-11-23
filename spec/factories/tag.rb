FactoryGirl.define do
  factory :tag do
    status Tag.statuses[:fixed]
    name { Faker::Lorem.word }

    trait :unfixed do
      status Tag.statuses[:unfixed]
    end

    trait :fixed do
      status Tag.statuses[:fixed]
    end
  end
end
