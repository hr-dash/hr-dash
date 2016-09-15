FactoryGirl.define do
  factory :tag do
    status Tag.statuses[:fixed]
    sequence(:name) { |i| "#{Faker::Lorem.word}#{i}" }

    trait :unfixed do
      status Tag.statuses[:unfixed]
    end

    trait :fixed do
      status Tag.statuses[:fixed]
    end
  end
end
