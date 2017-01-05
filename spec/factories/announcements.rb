FactoryGirl.define do
  factory :announcement do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    published_date { Time.current.to_date }
  end
end
