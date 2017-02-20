# frozen_string_literal: true
# == Schema Information
#
# Table name: help_texts
#
#  id         :integer          not null, primary key
#  category   :string
#  help_type  :string
#  target     :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :help_text do
    category { Faker::Lorem.word }
    help_type { Faker::Lorem.word }
    target { Faker::Lorem.word }
    body { Faker::Lorem.paragraph }

    trait :placeholder do
      help_type { 'placeholder' }
    end

    trait :hint do
      help_type { 'hint' }
    end
  end
end
