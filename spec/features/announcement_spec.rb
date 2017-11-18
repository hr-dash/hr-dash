# frozen_string_literal: true

describe AnnouncementsController, type: :feature do
  before { login }

  describe '#index GET /announcements' do
    let!(:announcement) { create(:announcement) }
    let(:list) { page.find('#announcement_index') }

    before { visit announcements_path }

    it { expect(list.find('a')).to have_content(announcement.title) }

    describe 'modal', js: true do
      before do
        page.execute_script %{ $("#announcement_#{announcement.id}").modal() }
      end

      let(:modal) { page.find('.modal.fade.in > .modal-dialog') }

      it { expect(modal).to have_content(announcement.title) }
    end
  end
end
