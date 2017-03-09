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

        it { expect(current_path).to eq monthly_reports_path }
        it { expect(find('div.tag > span').text).to eq tag.name }
        it { expect(query).to include "q[tags_name_in][]=#{tag.name}" }
      end
    end
  end

  describe '#show GET /monthly_reports/:id' do
    let(:user) { create(:user) }
    let(:report) { create(:shipped_monthly_report, user: user) }
    let!(:prev) { create(:shipped_monthly_report, user: user, target_month: report.target_month.prev_month) }
    let!(:next) { create(:monthly_report, :wip, user: user, target_month: report.target_month.next_month) }
    before { visit monthly_report_path(report) }

    it { expect(page).to have_link('先月') }
    it { expect(page).not_to have_link('来月') }
  end
end
