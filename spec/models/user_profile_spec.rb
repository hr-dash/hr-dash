# frozen_string_literal: true

# == Schema Information
#
# Table name: user_profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  self_introduction :text
#  blood_type        :integer          default("blood_blank"), not null
#  birthday          :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

describe UserProfile, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Validations' do
    subject { build(:user_profile) }

    it { is_expected.to validate_length_of(:self_introduction).is_at_most(1000) }
    it { is_expected.to validate_presence_of(:blood_type) }
  end
end
