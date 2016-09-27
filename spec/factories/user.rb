FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    association :group
    sequence(:employee_code) { |i| "#{i}#{Faker::Number.number(10)}" }
    sequence(:email) { |i| "#{i}#{Faker::Internet.email}" }
    entry_date { Faker::Date.between(3.years.ago, 1.year.ago) }
    beginner_flg { [true, false].sample }
    gender { User.genders.keys.sample }
  end
end
