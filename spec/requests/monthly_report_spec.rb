describe MonthlyReportsController, type: :request do
  let!(:report) { create(:monthly_report, :with_comments, :with_tags) }
  let(:user) { create(:user) }
  before { login user }

  describe '#index GET /monthly_reports' do
    before { get monthly_reports_path }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template('monthly_reports/index') }
    it { expect(response.body).to match report.user.name }
  end

  describe "root_path" do
    before { get root_path }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template('monthly_reports/index') }
  end

  describe '#mine GET /monthly_reports/mine' do
    before { get mine_monthly_reports_path }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template('monthly_reports/mine') }
    it { expect(response.body).to match user.name }
  end

  describe '#show GET /monthly_reports/:id' do
    before { get monthly_report_path(report) }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template('monthly_reports/show') }
    it { expect(response.body).to match report.user.name }
  end

  describe '#new GET /monthly_reports/new' do
    before { get new_monthly_report_path }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template('monthly_reports/new') }
  end

  describe '#create POST /monthly_reports' do
    let(:new_report) { build(:monthly_report) }
    let(:report_params) { new_report.attributes.reject { |k, _| k =~ /id\z/ || k =~ /_at/ } }
    let(:user_report) { MonthlyReport.find_by(user: user) }

    context 'valid' do
      let(:post_params) { { monthly_report: report_params } }
      before { post monthly_reports_path, post_params }
      it { expect(response).to have_http_status :redirect }
      it { expect(user_report.present?).to eq true }
    end

    context 'invalid' do
      let(:post_params) { { monthly_report: report_params.except('target_month') } }
      before { post monthly_reports_path, post_params }
      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template('monthly_reports/new') }
      it { expect(user_report.present?).to eq false }
    end
  end

  describe '#edit GET /monthly_reports/:id/edit' do
    context 'invalid' do
      before { get edit_monthly_report_path(report) }
      it { expect(response).to have_http_status :not_found }
    end

    context 'valid' do
      before do
        login report.user
        get edit_monthly_report_path(report, target_month: report.target_month)
      end

      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template('monthly_reports/edit') }
      it { expect(response.body).to match report.target_month.strftime('%Y年%m月') }
    end
  end

  describe '#update PATCH /monthly_report/:id' do
    let(:new_report) { build(:monthly_report) }
    let(:report_params) { new_report.attributes.reject { |k, _| k =~ /id\z/ || k =~ /_at/ } }
    let(:patch_params) { { monthly_report: report_params } }
    let(:user_report) { MonthlyReport.find_by(report_params, user: report.user) }
    context 'valid' do
      before do
        login report.user
        patch monthly_report_path report, patch_params
      end

      it { expect(response).to have_http_status :redirect }
      it { expect(user_report).to be_present }
    end

    context 'not_found' do
      before { patch monthly_report_path report, patch_params }
      it { expect(response).to have_http_status :not_found }
      it { expect(user_report).to be_nil }
    end
  end
end
