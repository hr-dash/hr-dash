# frozen_string_literal: true
describe MonthlyReportsController, type: :feature do
  before { login }

  describe '#index GET /monthly_reports' do
    describe 'sort by shipped_at desc' do
      let!(:today) { create(:monthly_report, :with_tags, shipped_at: Date.today) }
      let!(:yesterday) { create(:monthly_report, :with_tags, shipped_at: Date.yesterday) }
      let(:first_report) { find('#report_index').first('a') }

      before { visit monthly_reports_path }
      it { expect(first_report[:href]).to eq monthly_report_path(today) }
    end

    describe 'search', js: true do
      context 'by tag name' do
        let!(:tag) { create(:tag) }
        let(:url) { URI.parse(current_url) }
        let(:query) { URI.decode(url.query) }

        before do
          create_list(:monthly_report, 11, :shipped, tags: [tag])
          visit monthly_reports_path
          find('#monthly_report_tags_input').set(tag.name)
          click_button '検索'
          click_link '>'
        end

        it 'can search by tag name' do
          expect(current_path).to eq monthly_reports_path
          expect(find('div.tag > span').text).to eq tag.name
          expect(query).to include "q[tags_name_in][]=#{tag.name}"
        end
      end
    end

    context 'by target_month' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }
      let!(:user1) { create(:user, entry_date: 6.months.ago) }
      let(:month1) { 1.months.ago.beginning_of_month }
      let(:month2) { 2.months.ago.beginning_of_month }
      let!(:report1) { create(:monthly_report, :shipped, :with_tags, user: user1, target_month: month1) }
      let!(:report2) { create(:monthly_report, :shipped, :with_tags, user: user1, target_month: month2) }

      before do
        visit monthly_reports_path
        select report1.target_month.strftime('%Y年%m月'), from: 'q[target_month_eq]'
        click_button '検索'
      end

      it 'can search by month' do
        expect(current_path).to eq monthly_reports_path
        expect(query).to include "q[target_month_eq]=#{report1.target_month}"
        expect(query).not_to include "q[target_month_eq]=#{report2.target_month}"
      end
    end
  end

  describe '#show GET /monthly_reports/:id' do
    let(:user) { create(:user) }
    let(:report) { create(:shipped_monthly_report, user: user) }
    let!(:prev) { create(:shipped_monthly_report, user: user, target_month: report.target_month.prev_month) }
    let!(:next) { create(:monthly_report, :wip, user: user, target_month: report.target_month.next_month) }
    before { visit monthly_report_path(report) }

    it 'exists link for paging' do
      expect(page).to have_link('先月')
      expect(page).not_to have_link('来月')
    end
  end
end
