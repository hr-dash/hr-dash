FactoryGirl.define do
  factory :monthly_report do
    association :user
    month Faker::Number.between(1, 12)
    year Faker::Number.between(2000, 2020)
    project_summary Faker::Lorem.paragraph
    used_technology Faker::Lorem.paragraph
    responsible_business Faker::Lorem.paragraph
    business_content Faker::Lorem.paragraph
    looking_back Faker::Lorem.paragraph
    next_month_goals Faker::Lorem.paragraph
  end
end
