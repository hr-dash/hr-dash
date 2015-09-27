# == Schema Information
#
# Table name: monthly_comments
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  comment           :text
#  monthly_report_id :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe MonthlyComment, type: :model do
  it { expect(subject).to respond_to(:id) }
  it { expect(subject).to respond_to(:user_id) }
  it { expect(subject).to respond_to(:comment) }
  it { expect(subject).to respond_to(:monthly_report_id) }
end
