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

class UserProfile < ApplicationRecord
  belongs_to :user

  validates :self_introduction, length: { maximum: 1000 }
  validates :blood_type, presence: true

  enum blood_type: { blood_blank: 0, a: 1, b: 2, ab: 3, o: 4 }
end
