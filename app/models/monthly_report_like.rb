# frozen_string_literal: true

# == Schema Information
#
# Table name: monthly_report_likes
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  monthly_report_id :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class MonthlyReportLike < ApplicationRecord
  belongs_to :user
  belongs_to :monthly_report
  counter_culture :monthly_report, column_name: 'likes_count'

  validates :user, presence: true, uniqueness: { scope: :monthly_report }
  validates :monthly_report, presence: true
end
