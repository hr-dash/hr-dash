# frozen_string_literal: true
describe MonthlyReportCommentsController, type: :feature do
  let(:user) { create(:user) }
  let(:report) { create(:monthly_report, :shipped, :with_tags) }

  before { login user }

  context 'when monthly report is not liked' do
    before do
      visit monthly_report_path(report)
    end

    it 'displays Like! btn', js: true do
      expect(page).to have_content 'いいね！'
    end

    it 'can change to Liked by clicking the btn', js: true do
      click_on 'いいね！'
      expect(page).to have_content 'いいね済み'
    end
  end

  context 'when monthly report is liked' do
    before do
      report.likes.create(user: user)
      visit monthly_report_path(report)
    end

    it 'displays Liked btn', js: true do
      expect(page).to have_content 'いいね済み'
    end

    it 'can change to Like! btn by clicking the btn', js: true do
      click_on 'いいね済み'
      expect(page).to have_content 'いいね！'
    end
  end
end
