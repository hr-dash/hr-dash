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

FactoryGirl.define do
  factory :monthly_working_process do
    association :monthly_report
    process_definition { [true, false].sample }
    process_design { [true, false].sample }
    process_implementation { [true, false].sample }
    process_test { [true, false].sample }
    process_operation { [true, false].sample }
    process_training { [true, false].sample }
  end
end
