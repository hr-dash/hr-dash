FactoryGirl.define do
  factory :admin_user do
    email Faker::Internet.email
    password Faker::Internet.password(8)
  end
end
