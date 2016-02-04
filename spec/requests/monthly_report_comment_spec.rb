describe MonthlyReportCommentsController, type: :request do
  let(:user) { create(:user) }
  let(:report) { create(:monthly_report) }

  before { login user }

  describe '#create POST /monthly_report_comments' do
    let(:comment) { build(:monthly_report_comment, monthly_report: report) }
    let(:comment_params) { { monthly_report_comment: comment.attributes.slice('comment', 'monthly_report_id') } }

    before { post monthly_report_comments_path, comment_params }

    it { expect(response).to have_http_status :redirect }
    it { expect(user.monthly_report_comments.size).to eq 1 }
    it { expect(user.monthly_report_comments.first.comment).to eq comment.comment }
  end

  describe '#edit GET /monthly_report_comments/:id/edit' do
    let(:comment) { create(:monthly_report_comment, monthly_report: report, user: user) }

    before { get edit_monthly_report_comment_path(comment) }

    it { expect(response).to have_http_status :success }
    it { expect(response.body).to match comment.comment }
    it { expect(response).to render_template('monthly_reports/_new_comment') }
  end

  describe '#update PATCH /monthly_report_comments/:id' do
    let(:comment) { create(:monthly_report_comment, monthly_report: report, user: user) }
    let(:after_comment) { build(:monthly_report_comment, monthly_report: report) }
    let(:comment_params) { { monthly_report_comment: { monthly_report_id: report.id, comment: after_comment.comment } } }

    before { patch monthly_report_comment_path(comment), comment_params }

    it { expect(response).to have_http_status :redirect }
    it { expect(user.monthly_report_comments.size).to eq 1 }
    it { expect(report.comments.first.comment).to eq after_comment.comment }
  end

  describe '#destroy DELETE /monthly_report_comments/:id' do
    let(:comment) { create(:monthly_report_comment, monthly_report: report, user: user) }

    before { delete monthly_report_comment_path(comment) }

    it { expect(response).to have_http_status :redirect }
    it { expect(report.comments.size).to eq 0 }
    it { expect { comment.reload }.to raise_error ActiveRecord::RecordNotFound }
  end
end
