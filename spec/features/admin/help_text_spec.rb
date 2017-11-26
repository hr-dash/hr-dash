# frozen_string_literal: true

describe 'Admin::HelpText', type: :feature do
  before { login(admin: true) }
  let!(:help_text) { create(:help_text) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_help_texts_path }
    it 'should open the index page' do
      expect(page_title).to have_content('ヘルプテキスト')
      expect(page).to have_content(help_text.category)
      expect(page).not_to have_content('作成する')
      expect(page).not_to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_help_text_path(help_text) }
    it 'should open the show page' do
      expect(page_title).to have_content("##{help_text.id}")
      expect(page).to have_content(help_text.category)
      expect(page).to have_content(help_text.target)
      expect(page).to have_content(help_text.body)
    end
  end

  describe '#update' do
    let(:new_body) { Faker::Lorem.paragraph }
    before do
      visit edit_admin_help_text_path(help_text)
      fill_in 'テキスト', with: new_body
      click_on 'ヘルプテキストを更新'
    end

    it 'should update the help text' do
      expect(page_title).to have_content("##{help_text.id}")
      expect(current_path).to eq admin_help_text_path(help_text)
      expect(page).to have_content(new_body)
      expect(help_text.reload.body).to eq new_body
    end
  end
end
