# == Schema Information
#
# Table name: monthly_reports
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  target_month     :datetime         not null
#  project_summary  :text
#  working_process  :integer          is an Array
#  business_content :text
#  looking_back     :text
#  next_month_goals :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class MonthlyReport < ActiveRecord::Base
  belongs_to :user
  has_many :monthly_report_comments, dependent: :destroy
  has_many :monthly_report_tags, dependent: :destroy
  has_many :tags, through: :monthly_report_tags
  has_many :monthly_working_processes, dependent: :destroy

  validates :user_id, numericality: { only_integer: true }, presence: true
  validates :target_month, presence: true
  validate :is_target_beginning_of_month

  private

  def is_target_beginning_of_month
    return if target_month.blank?
    return if target_month == target_month.beginning_of_month
    errors.add :target_month, "invalid target month"
  end
end
