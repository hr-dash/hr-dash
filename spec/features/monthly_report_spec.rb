describe MonthlyReportsController, type: :feature do
  before { login }

  describe '#index GET /monthly_reports' do
    describe 'sort by shipped_at desc' do
      let!(:today) { create(:monthly_report, shipped_at: Date.today) }
      let!(:yesterday) { create(:monthly_report, shipped_at: Date.yesterday) }
      let(:first_report) { find('#report_index').first('a') }

      before { visit monthly_reports_path }
      it { expect(first_report[:href]).to eq monthly_report_path(today) }
    end
  end
end
