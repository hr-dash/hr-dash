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

RSpec.describe Tag, type: :model do
  it { expect(subject).to respond_to(:id) }
  it { expect(subject).to respond_to(:name) }

  it 'is valid with name' do
    tag = create(:tag)
    expect(tag).to be_valid
  end
end
