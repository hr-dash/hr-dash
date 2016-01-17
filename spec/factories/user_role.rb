FactoryGirl.define do
  factory :user_role do
    association :user
    admin false

    trait :admin do
      admin true
    end
  end
end
