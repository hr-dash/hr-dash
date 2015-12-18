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

  validates :user_id, numericality: { only_integer: true }, presence: true
  validates :monthly_report_id, numericality: { only_integer: true },
                                presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
