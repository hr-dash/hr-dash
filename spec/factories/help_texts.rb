FactoryGirl.define do
  factory :help_text do
    category { Faker::Lorem.word }
    help_type { Faker::Lorem.word }
    target { Faker::Lorem.word }
    body { Faker::Lorem.paragraph }
  end
end
