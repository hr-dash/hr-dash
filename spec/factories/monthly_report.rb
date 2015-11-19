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

    trait :with_comments do
      transient do
        comment_size 3
      end

      after(:create) do |report, evaluator|
        evaluator.comment_size.times do
          create(:monthly_report_comment, monthly_report: report)
        end
      end
    end

    trait :with_tags do
      transient do
        tag_size 3
      end

      after(:create) do |report, evaluator|
        evaluator.tag_size.times do
          create(:monthly_report_tag, monthly_report: report)
        end
      end
    end
  end
end
