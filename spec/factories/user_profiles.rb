FactoryGirl.define do
  factory :user_profile do
    association :user
    self_introduction Faker::Lorem.paragraph
    gender { UserProfile.genders.keys.sample }
    blood_type { UserProfile.blood_types.keys.sample }
    birthday { Faker::Date.between(100.years.ago, Date.today) }
  end
end
