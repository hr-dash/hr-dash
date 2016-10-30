FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:employee_code) { |i| "#{i}#{Faker::Number.number(10)}" }
    sequence(:email) { |i| "#{i}#{Faker::Internet.email}" }
    entry_date { Faker::Date.between(3.years.ago, 1.year.ago) }
    beginner_flg { [true, false].sample }
    gender { User.genders.keys.sample }

    transient do
      group_size 1
    end

    after(:create) do |user, evaluator|
      evaluator.group_size.times do
        create(:group_assignment, user: user)
      end
    end
  end
end
