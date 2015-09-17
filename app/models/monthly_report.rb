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
end
