# frozen_string_literal: true
# == Schema Information
#
# Table name: inquiries
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  body       :text             not null
#  referer    :string
#  user_agent :string
#  session_id :string
#  admin_memo :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :inquiry do
    association :user
    body { Faker::Lorem.paragraph }
    referer { Faker::Internet.url }
    user_agent { Faker::Lorem.sentence }
    session_id { Faker::Lorem.characters(32) }
  end
end
