# == Schema Information
#
# Table name: monthly_working_processes
#
#  id                     :integer          not null, primary key
#  monthly_report_id      :integer
#  process_definition     :boolean          default(FALSE), not null
#  process_design         :boolean          default(FALSE), not null
#  process_implementation :boolean          default(FALSE), not null
#  process_test           :boolean          default(FALSE), not null
#  process_operation      :boolean          default(FALSE), not null
#  process_analysis       :boolean          default(FALSE), not null
#  process_training       :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class MonthlyWorkingProcess < ActiveRecord::Base
  Processes = self.column_names.select { |c| c.match /\Aprocess_/ }

  belongs_to :monthly_report

  validates :monthly_report, presence: true
  Processes.each do |column|
    validates column, inclusion: { in: [true, false] }
  end

  def processes
    Processes.reduce({}) do |hash, process|
      hash.merge!({ process => self.send(process) })
    end
  end
end
