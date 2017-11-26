# frozen_string_literal: true

# == Schema Information
#
# Table name: active_admin_action_logs
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  resource_id   :integer
#  resource_type :string
#  path          :string
#  action        :string
#  changes_log   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe ActiveAdminActionLog, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :resource }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:resource) }
    it { is_expected.to validate_presence_of(:path) }
    it { is_expected.to validate_presence_of(:action) }
  end
end
