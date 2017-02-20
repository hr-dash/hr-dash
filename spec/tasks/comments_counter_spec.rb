# frozen_string_literal: true
describe 'comments_counter' do
  let(:report) { create(:monthly_report, :with_comments, comment_size: comment_size) }
  let(:comment_size) { Faker::Number.between(1, 10) }

  before do
    # set wrong count
    report.update(comments_count: 0)
    Rake::Task['comments_counter:calculate'].invoke
  end

  describe 'calculate' do
    it { expect(report.reload.comments_count).to eq comment_size }
  end
end
