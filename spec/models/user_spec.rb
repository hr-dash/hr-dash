# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string
#  group_id      :integer
#  employee_code :integer
#  email         :string
#  entry_date    :date
#  beginner_flg  :boolean
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

describe User, type: :model do
  let(:user) do
    User.new(
      name: name,
      group_id: group_id,
      employee_code: e_code,
      email: email,
      entry_date: entry_date,
      beginner_flg: b_flg,
      deleted_at: del_at
    )
  end
  let(:name) { 'hoge' }
  let(:group_id) { 1 }
  let(:e_code) { 1 }
  let(:email) { 'hoge@example.com' }
  let(:entry_date) { '2010-04-01' }
  let(:b_flg) { true }
  let(:del_at) { '' }
  describe '.new' do
    context 'correct params' do
      it { expect(user).to be_valid }
    end

    context 'incorrect params' do
      context 'invalid if group id is string' do
        let(:group_id) { 'one' }
        it { expect(user).not_to be_valid }
      end
      context 'invalid if employee_code is strig' do
        let(:e_code) { 'one' }
        it { expect(user).not_to be_valid }
      end
      context 'invalid if email is unformat with mailaddress'do
        let(:email) { 'hoge@@ex..ample$%.com' }
        it { expect(user).not_to be_valid }
      end
      context 'invalid if beginner flg is nil' do
        let(:b_flg) { nil }
        it { expect(user).not_to be_valid }
      end
    end
  end
end
