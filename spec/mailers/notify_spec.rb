require "rails_helper"
RSpec.describe Notify, type: :mailer do
  let!(:report) { create(:monthly_report, :with_comments, :with_tags) }
  let(:user) { create(:user) }
  let(:from) { Settings.mailer[:from] } 

  after(:all) do
    ActionMailer::Base.deliveries.clear
  end

  describe "monthly_report_registration" do
    let(:mail) { Notify.monthly_report_registration(user.id,report.id) }
    let(:name) { user.name }
    let(:created_at) { report.created_at.strftime('%Y年%m月') }
    let(:title) { "#{name}が#{created_at}の月報を登録しました" }
    
    it "deliver_now" do
      expect { mail.deliver_now }.to change{ ActionMailer::Base.deliveries.count }.from(0).to(1)
    end

    it "renders the headers" do
      expect(mail.subject).to eq(title)
      expect(mail.to).to include(user.email)
      expect(mail.from[0]).to eq(from)
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(report.project_summary)
      expect(mail.body.encoded).to match(user.name)
    end
  end

end
