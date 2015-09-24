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

require 'rails_helper'

RSpec.describe MonthlyReportTag, type: :model do
  it { expect(subject).to respond_to(:id) }
  it { expect(subject).to respond_to(:monthly_report_id) }
  it { expect(subject).to respond_to(:tag_id) }
end
