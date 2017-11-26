# frozen_string_literal: true

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
#  process_structure      :boolean          default(FALSE), not null
#  process_trouble        :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

describe MonthlyWorkingProcess, type: :model do
  describe 'Validations' do
    subject { build(:monthly_working_process) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:monthly_report) }
  end
end
