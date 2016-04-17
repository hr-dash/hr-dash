FactoryGirl.define do
  factory :help_text do
    category { Faker::Lorem.word }
    help_type { Faker::Lorem.word }
    target { Faker::Lorem.word }
    body { Faker::Lorem.paragraph }

    trait :placeholder do
      help_type { 'placeholder' }
    end
  end
end
