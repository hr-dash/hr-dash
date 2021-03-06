# frozen_string_literal: true

describe 'Admin::MonthlyReportTag', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:report) { create(:monthly_report, user: user) }
  let(:tag) { report_tag.tag }
  let!(:report_tag) { create(:monthly_report_tag, monthly_report: report) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_monthly_report_tags_path }
    it 'should open the index page' do
      expect(page_title).to have_content('月報タグ')
      expect(page).to have_content(tag.name)
      expect(page).to have_css('.delete_link')
    end
  end

  describe '#show' do
    before { visit admin_monthly_report_tag_path(report_tag) }
    it { expect(page).to have_content(tag.name) }
  end

  describe '#update' do
    let!(:new_tag) { create(:tag) }
    before do
      visit edit_admin_monthly_report_tag_path(report_tag)
      select new_tag.name, from: 'monthly_report_tag_tag_id'
      click_on '月報タグを更新'
    end

    it 'should update the monthly report tag' do
      expect(page).to have_content(new_tag.name)
      expect(current_path).to eq admin_monthly_report_tag_path(report_tag)
      expect(report_tag.reload.tag).to eq new_tag
    end
  end

  describe '#destroy', js: true do
    before do
      visit admin_monthly_report_tags_path
      accept_confirm do
        find("#monthly_report_tag_#{report_tag.id}").find('.delete_link').click
      end
    end

    it 'should destroy the monthly report tag' do
      expect(current_path).to eq admin_monthly_report_tags_path
      expect(page).not_to have_content(tag.name)
      expect { report_tag.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
