# frozen_string_literal: true
# == Schema Information
#
# Table name: daily_report_comments
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  comment         :text
#  daily_report_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class DailyReportComment < ApplicationRecord
  belongs_to :user
  belongs_to :daily_report
  counter_culture :daily_report, column_name: 'comments_count'

  validates :user, presence: true
  validates :daily_report, presence: true
  validates :comment, presence: true, length: { maximum: 3000 }
end
