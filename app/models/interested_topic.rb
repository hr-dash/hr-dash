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

class InterestedTopic < ApplicationRecord
  belongs_to :user_profile
  belongs_to :tag
end
