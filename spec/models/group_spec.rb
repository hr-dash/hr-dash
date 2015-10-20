# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  group_name :string
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Group, type: :model do
  it { expect(subject).to respond_to :group_name }
  it 'is valid with group name' do
    group = Group.new(group_name: 'hoge')
    expect(group).to be_valid
  end
end
