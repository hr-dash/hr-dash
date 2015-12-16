FactoryGirl.define do
  factory :group do
    name { Faker::Name.name }
  end
end
