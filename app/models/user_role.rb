# == Schema Information
#
# Table name: user_roles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  admin      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserRole < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
end
