FactoryGirl.define do
  factory :group_assignment do
    association :group
    association :user
  end
end
