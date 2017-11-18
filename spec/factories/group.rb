# frozen_string_literal: true

FactoryGirl.define do
  factory :group do
    name { Faker::Name.name }

    if Rails.env.development?
      email { ENV['SYSTEM_MAIL'] }
    else
      sequence(:email) { |i| "#{i}#{Faker::Internet.email}" }
    end

    description { Faker::Lorem.paragraph }
  end
end
