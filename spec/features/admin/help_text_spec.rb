# frozen_string_literal: true
describe 'Admin::HelpText', type: :feature do
  before { login(admin: true) }
  let!(:help_text) { create(:help_text) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_help_texts_path }
    it { expect(page_title).to have_content('ヘルプテキスト') }
    it { expect(page).to have_content(help_text.category) }
    it { expect(page).not_to have_content('作成する') }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_help_text_path(help_text) }
    it { expect(page_title).to have_content("##{help_text.id}") }
    it { expect(page).to have_content(help_text.category) }
    it { expect(page).to have_content(help_text.target) }
    it { expect(page).to have_content(help_text.body) }
  end

  describe '#update' do
    let(:new_body) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_help_text_path(help_text)
      fill_in 'テキスト', with: new_body
      click_on 'ヘルプテキストを更新'
    end

    it { expect(page_title).to have_content("##{help_text.id}") }
    it { expect(current_path).to eq admin_help_text_path(help_text) }
    it { expect(page).to have_content(new_body) }
    it { expect(help_text.reload.body).to eq new_body }
  end
end
