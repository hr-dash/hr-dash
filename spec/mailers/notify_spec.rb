require 'rails_helper'
RSpec.describe Mailer::Notify, type: :mailer do
  let!(:report) { create(:monthly_report, :with_comments, :with_tags) }
  let(:user) { create(:user) }
  let(:from) { 'test@example.com' }

  before(:all) do
    ActionMailer::Base.deliveries.clear
  end

  describe 'monthly_report_registration' do
    let(:mail) { Mailer::Notify.monthly_report_registration(user.id, report.id) }
    let(:name) { user.name }
    let(:target_at) { report.target_month.strftime('%Y年%m月') }
    let(:title) { "#{name}が#{target_at}の月報を登録しました" }
    let(:mail_body) { mail.body.raw_source }
    it { expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.from(0).to(1) }
    it { expect(mail.subject).to eq(title) }
    it { expect(mail.to).to eq user.groups.map(&:email) }
    it { expect(mail.from[0]).to eq(from) }
    it { expect(mail_body).to match(report.project_summary) }
    it { expect(mail_body).to match(user.name) }
    it { expect(mail_body).to match("#{target_at}の業務報告") }
    it { expect(mail_body).to match("#{monthly_report_path(report)}") }
    it { expect(mail_body).to match('Dash') }

    context 'if user does not belong to group' do
      let(:user) { create(:user, group_size: 0) }
      it { expect { mail.deliver_now }.not_to change { ActionMailer::Base.deliveries.count } }
    end
  end
end
