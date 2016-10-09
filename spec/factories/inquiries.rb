FactoryGirl.define do
  factory :inquiry do
    association :user
    body { Faker::Lorem.paragraph }
  end
end
