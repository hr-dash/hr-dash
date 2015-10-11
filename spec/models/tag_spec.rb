# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Tag, type: :model do
  it { expect(subject).to respond_to(:id) }
  it { expect(subject).to respond_to(:name) }

  let(:tag) { build(:tag) }
  it 'is valid with name' do
    expect(tag).to be_valid
  end

  describe '.new' do
    context 'correct params' do
      it { expect(tag).to be_valid }
    end
    context 'incorrect params' do
      before{ tag.name = nil }
      it { expect(tag).not_to be_valid }
    end
  end
end
