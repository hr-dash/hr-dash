# frozen_string_literal: true
# == Schema Information
#
# Table name: interested_topics
#
#  id              :integer          not null, primary key
#  user_profile_id :integer          not null
#  tag_id          :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :interested_topic do
    association :user_profile
    association :tag
  end
end
