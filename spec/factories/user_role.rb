FactoryGirl.define do
  factory :user_role do
    association :user
    role { UserRole.roles.values.sample }

    trait :admin do
      role { UserRole.roles[:admin] }
    end

    trait :operator do
      role { UserRole.roles[:operator] }
    end
  end
end
