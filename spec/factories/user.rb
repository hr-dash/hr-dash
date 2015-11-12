FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    association :group
    employee_code Faker::Number.number(10)
    email Faker::Internet.email
    password Faker::Internet.password(8)
    entry_date Faker::Date.between(3.years.ago, Date.today)
    beginner_flg { [true, false].sample }
  end
end
