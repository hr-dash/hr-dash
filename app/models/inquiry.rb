# == Schema Information
#
# Table name: inquiries
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  body       :text             not null
#  referer    :string
#  user_agent :string
#  session_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Inquiry < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :body, presence: true, length: { maximum: 3000 }
end
