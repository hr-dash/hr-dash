FactoryGirl.define do
  factory :monthly_report_tag do
    association :monthly_report
    association :tag
  end
end
