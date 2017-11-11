# frozen_string_literal: true
# == Schema Information
#
# Table name: monthly_report_likes
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  monthly_report_id :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :monthly_report_like do
    association :user
    association :monthly_report
  end
end
