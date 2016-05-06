# == Schema Information
#
# Table name: user_profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  self_introduction :text
#  gender            :integer          default(0), not null
#  blood_type        :integer          default(0), not null
#  birthday          :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class UserProfile < ActiveRecord::Base
  belongs_to :user

  validates :self_introduction, length: { maximum: 1000 }
  validates :gender, presence: true
  validates :blood_type, presence: true

  enum blood_type: { blood_unknown: 0, a: 1, b: 2, ab: 3, o: 4 }
end
