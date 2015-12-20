# == Schema Information
#
# Table name: monthly_working_processes
#
#  id                :integer          not null, primary key
#  monthly_report_id :integer
#  process           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :monthly_working_process do
    association :monthly_report
    process { MonthlyWorkingProcess.processes.keys.sample }
  end
end
