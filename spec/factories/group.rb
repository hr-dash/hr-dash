FactoryGirl.define do
  factory :group do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
  end
end
