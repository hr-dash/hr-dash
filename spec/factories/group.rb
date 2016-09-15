FactoryGirl.define do
  factory :group do
    name { Faker::Name.name }
    sequence(:email) { |i| "#{i}#{Faker::Internet.email}" }
    description { Faker::Lorem.paragraph }
  end
end
