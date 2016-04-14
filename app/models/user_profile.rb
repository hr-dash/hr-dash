# == Schema Information
#
# Table name: user_profiles
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  self_introduction :text
#  gender            :integer          default(0), not null
#  blood_type        :integer          default(0), not null
#  birthday          :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class UserProfile < ActiveRecord::Base
  belongs_to :user

  validates :gender, presence: true
  validates :blood_type, presence: true

  enum gender: { gender_blank: 0, male: 1, female: 2 }
  enum blood_type: { blood_blank: 0, a: 1, b: 2, ab: 3, o: 4 }
end
