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

require 'rails_helper'

RSpec.describe MonthlyReport, type: :model do

  it { expect(subject).to respond_to(:users_id) }
  it { expect(subject).to respond_to(:project_summary) }
  it { expect(subject).to respond_to(:used_technology) }
  it { expect(subject).to respond_to(:responsible_business) }
  it { expect(subject).to respond_to(:business_content) }
  it { expect(subject).to respond_to(:looking_back) }
  it { expect(subject).to respond_to(:next_month_goals) }
  it { expect(subject).to respond_to(:month) }
  it { expect(subject).to respond_to(:year) }

end
