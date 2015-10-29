# == Schema Information
#
# Table name: monthly_report_tags
#
#  id                :integer          not null, primary key
#  monthly_report_id :integer          not null
#  tag_id            :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class MonthlyReportTag < ActiveRecord::Base
  validates :monthly_report_id, numericality: { only_integer: true },
                                presence: true
  validates :tag_id, numericality: { only_integer: true }, presence: true
end
