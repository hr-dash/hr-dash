RSpec.describe Mailer::EndOfMonth, type: :mailer do
  let(:from) { 'test@example.com' }

  before(:all) do
    ActionMailer::Base.deliveries.clear
  end

  describe '#notice' do
    let(:mail) { Mailer::EndOfMonth.notice }
    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.from(0).to(1) }
    it { expect(mail.to).to eq [ENV['MAILING_LIST_TO_ALL_USER']] }
    it { expect(mail.from[0]).to eq(from) }
    it { expect(mail.body).to match('/monthry_report/new') }
  end
end
