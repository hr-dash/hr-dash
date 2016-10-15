describe 'Admin::Inquiry', type: :feature do
  before { login(admin: true) }
  let!(:inquiry) { create(:inquiry) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_inquiries_path }
    it { expect(page_title).to have_content('問い合わせ') }
    it { expect(page).to have_content(inquiry.referer) }
    it { expect(page).to have_content('編集') }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_inquiry_path(inquiry) }
    it { expect(page_title).to have_content("問い合わせ ##{inquiry.id}") }
    it { expect(page).to have_content(inquiry.user.name) }
    it { expect(page).to have_content(inquiry.body) }
  end

  describe '#update' do
    let(:new_admin_memo) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_inquiry_path(inquiry)
      fill_in '管理用メモ', with: new_admin_memo
      click_on 'Update 問い合わせ'
    end

    it { expect(page_title).to have_content("問い合わせ ##{inquiry.id}") }
    it { expect(current_path).to eq admin_inquiry_path(inquiry) }
    it { expect(page).to have_content(new_admin_memo) }
    it { expect(inquiry.reload.admin_memo).to eq new_admin_memo }
  end
end
