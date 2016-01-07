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

class MonthlyWorkingProcess < ActiveRecord::Base
  belongs_to :monthly_report

  enum process: {
    definition: 0,
    design: 1,
    implementation: 2,
    test: 3,
    operation: 4,
    analysis: 5,
  }
end
