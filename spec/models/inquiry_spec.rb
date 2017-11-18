# frozen_string_literal: true

# == Schema Information
#
# Table name: inquiries
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  body       :text             not null
#  referer    :string
#  user_agent :string
#  session_id :string
#  admin_memo :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe Inquiry, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Validations' do
    subject { build(:inquiry) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(3000) }
  end
end
