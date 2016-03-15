# == Schema Information
#
# Table name: monthly_report_comments
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  comment           :text
#  monthly_report_id :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class MonthlyReportComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :monthly_report

  validates :user, presence: true
  validates :monthly_report, presence: true
  validates :comment, presence: true, length: { maximum: 3000 }
end
