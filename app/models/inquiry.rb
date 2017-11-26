# frozen_string_literal: true

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
#  admin_memo :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Inquiry < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :body, presence: true, length: { maximum: 3000 }
end
