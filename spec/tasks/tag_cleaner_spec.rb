describe 'tag_cleaner' do
  describe 'delete_unused_tags' do
    let(:used_tag) { create(:tag, status: :unfixed) }
    let!(:unused_tag) { create(:tag, status: :unfixed) }
    let!(:fixed_tag) { create(:tag, status: :fixed) }
    before { create(:monthly_report_tag, tag: used_tag) }

    context 'dry_run' do
      before { Rake::Task['tag_cleaner:delete_unused_tags'].invoke }
      it { expect(used_tag.reload).to be_present }
      it { expect(unused_tag.reload).to be_present }
      it { expect(fixed_tag.reload).to be_present }
    end

    context 'exec delete' do
      before { Rake::Task['tag_cleaner:delete_unused_tags'].invoke 'true' }
      it { expect(used_tag.reload).to be_present }
      it { expect { unused_tag.reload }.to raise_error(ActiveRecord::RecordNotFound) }
      it { expect(fixed_tag.reload).to be_present }
    end
  end
end
