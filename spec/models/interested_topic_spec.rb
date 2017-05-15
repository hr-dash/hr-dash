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

describe InterestedTopic, type: :model do
  it { expect(subject).to respond_to(:id) }
  it { expect(subject).to respond_to(:user_profile_id) }
  it { expect(subject).to respond_to(:tag_id) }
end
