# frozen_string_literal: true
describe InquiriesController, type: :feature do
  let(:user) { create(:user) }
  before { login user }

  describe '#create POST /inquires', js: true do
    let(:body) { build(:inquiry).body }
    let(:inquiry) { Inquiry.last }

    before do
      ActionMailer::Base.deliveries.clear

      visit root_path
      page.execute_script %{ $('#new_inquiry').modal('show') }
      find('#inquiry_body').set(body)
      find('button.btn-success').trigger('click')
      wait_for_ajax
    end

    context 'success' do
      describe 'created inquiry record' do
        it { expect(inquiry.user).to eq user }
        it { expect(inquiry.body).to eq body }
      end

      describe 'send inquiry mail' do
        it { expect(ActionMailer::Base.deliveries.size).to eq 1 }
      end
    end

    context 'failed' do
      let(:body) { '' }

      describe 'not created inquiry record' do
        it { expect(inquiry).to be_nil }
      end

      describe 'not send inquiry mail' do
        it { expect(ActionMailer::Base.deliveries.size).to eq 0 }
      end
    end
  end
end
