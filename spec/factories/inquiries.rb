FactoryGirl.define do
  factory :inquiry do
    association :user
    body { Faker::Lorem.paragraph }
    referer { Faker::Internet.url }
    user_agent { Faker::Lorem.sentence }
    session_id { Faker::Lorem.characters(32) }
  end
end
