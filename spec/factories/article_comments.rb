# frozen_string_literal: true
# == Schema Information
#
# Table name: article_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  comment    :text
#  article_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :article_comment do
    association :user
    association :article
    comment { Faker::Lorem.paragraph }
  end
end
