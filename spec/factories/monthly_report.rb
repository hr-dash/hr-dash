FactoryGirl.define do
  factory :monthly_report do
    association :user
    target_month { Faker::Date.between(6.months.ago, 1.months.ago).beginning_of_month }
    project_summary { Faker::Lorem.paragraph }
    business_content { Faker::Lorem.paragraph }
    looking_back { Faker::Lorem.paragraph }
    next_month_goals { Faker::Lorem.paragraph }

    trait :shipped do
      shippted_at { Time.current }
    end

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

      after(:build) do |report, evaluator|
        evaluator.tag_size.times do
          report.monthly_report_tags << build(:monthly_report_tag, monthly_report: report)
        end
      end
    end

    trait :with_working_processes do
      after(:build) do |report|
        report.monthly_working_processes << build(:monthly_working_process, monthly_report: report)
      end
    end

    factory :shipped_montly_report, traits: [:shipped, :with_tags, :with_working_processes]
  end
end
