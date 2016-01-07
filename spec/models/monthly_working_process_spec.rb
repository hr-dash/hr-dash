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

require 'rails_helper'

RSpec.describe MonthlyWorkingProcess, type: :model do
  describe 'Validations' do
    subject { build(:monthly_working_process) }

    it { is_expected.to be_valid }
  end
end
