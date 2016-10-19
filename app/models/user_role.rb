# == Schema Information
#
# Table name: user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserRole < ActiveRecord::Base
  belongs_to :user

  enum role: {
    admin: 0,
    operator: 1,
  }

  validates :user, presence: true
  validates :role, presence: true
end
