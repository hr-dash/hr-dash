require "rails_helper"

RSpec.describe Notify, type: :mailer do
  describe "monthly_report_registration" do
    let(:mail) { Notify.monthly_report_registration }

    it "renders the headers" do
      expect(mail.subject).to eq("Monthly report registration")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
