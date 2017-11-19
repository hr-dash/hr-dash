# frozen_string_literal: true

# == Schema Information
#
# Table name: article_tags
#
#  id         :integer          not null, primary key
#  tag_id     :integer          not null
#  article_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :article_tag do
    association :article
    association :tag
  end
end
