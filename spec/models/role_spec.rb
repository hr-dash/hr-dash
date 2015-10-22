# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Role, type: :model do
  it { expect(subject).to respond_to(:name) }

  let(:role) { Role.new(name: name) }
  let(:name) { 'hoge' }
  it 'should be valid' do
    expect(role).to be_valid
  end
end
