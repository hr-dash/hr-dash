# frozen_string_literal: true

FactoryGirl.define do
  factory :monthly_report do
    association :user
    target_month { Faker::Date.between(6.months.ago, 2.months.ago).beginning_of_month }
    project_summary { Faker::Lorem.paragraph }
    business_content { Faker::Lorem.paragraph }
    looking_back { Faker::Lorem.paragraph }
    next_month_goals { Faker::Lorem.paragraph }

    after(:build) do |report|
      report.monthly_working_process = build(:monthly_working_process, monthly_report: report)
    end

    trait :wip do
      shipped_at { nil }
    end

    trait :shipped do
      shipped_at { Time.current }
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

    trait :with_likes do
      transient do
        like_size 3
      end

      after(:create) do |report, evaluator|
        evaluator.like_size.times do
          create(:monthly_report_like, monthly_report: report)
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

    factory :shipped_monthly_report, traits: %i[shipped with_tags]
  end
end
