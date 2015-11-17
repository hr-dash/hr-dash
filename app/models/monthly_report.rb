# == Schema Information
#
# Table name: monthly_reports
#
#  id                   :integer          not null, primary key
#  user_id              :integer          not null
#  project_summary      :text
#  used_technology      :text
#  responsible_business :text
#  business_content     :text
#  looking_back         :text
#  next_month_goals     :text
#  month                :integer          not null
#  year                 :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class MonthlyReport < ActiveRecord::Base
  belongs_to :user
  has_many :monthly_report_comments, dependent: :destroy
  has_many :monthly_report_tags
  has_many :tags, through: :monthly_report_tags

  validates :user_id, numericality: { only_integer: true }, presence: true
  validates :month, numericality: { only_integer: true },
                    inclusion: { in: 1..12 },
                    presence: true
  validates :year, numericality: { only_integer: true,
                                   greater_than_or_equal_to: 2000 },
                   presence: true
end
