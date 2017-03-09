# frozen_string_literal: true
FactoryGirl.define do
  factory :monthly_report_comment do
    association :user
    association :monthly_report
    comment { Faker::Lorem.paragraph }
  end
end
