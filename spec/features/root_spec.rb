# frozen_string_literal: true

describe RootController, type: :feature do
  before { login }

  describe '#index GET /' do
    before { visit root_path }
    let(:page_contents) { page.all('.page-content') }

    it { expect(current_path).to eq root_path }
    it { expect(page_contents.first).to have_content('お知らせ') }
    it { expect(page_contents.last).to have_content('最近投稿された月報') }
  end
end
