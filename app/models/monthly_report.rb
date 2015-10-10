# == Schema Information
#
# Table name: monthly_reports
#
#  id                   :integer          not null, primary key
#  users_id             :integer          not null
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
  validates :users_id, numericality: { only_integer: true }, presence: true
  validates :month, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 12 },
                    presence: true
  validates :year, numericality:  { only_integer: true,
                                    greater_than_or_equal_to: 2015 },
                   presence: true
end