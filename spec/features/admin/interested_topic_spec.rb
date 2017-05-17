# frozen_string_literal: true
describe 'Admin::InterestedTopic', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:profile) { user.user_profile }
  let(:tag) { topic.tag }
  let!(:topic) { create(:interested_topic, user_profile: profile) }

  describe '#index' do
    let(:page_title) { find('#page_title') }
    before { visit admin_interested_topics_path }
    it { expect(page_title).to have_content('興味のある技術') }
    it { expect(page).to have_content(tag.name) }
  end

  describe '#show' do
    before { visit admin_interested_topic_path(topic) }
    it { expect(page).to have_content(tag.name) }
  end

  describe '#update' do
    let!(:new_tag) { create(:tag) }
    before do
      visit edit_admin_interested_topic_path(topic)
      select new_tag.name, from: 'interested_topic_tag_id'
      click_on '興味のある技術を更新'
    end

    it { expect(page).to have_content(new_tag.name) }
    it { expect(current_path).to eq admin_interested_topic_path(topic) }
    it { expect(topic.reload.tag).to eq new_tag }
  end

  describe '#destroy', js: true do
    before do
      visit admin_interested_topics_path
      accept_confirm do
        find("#interested_topic_#{topic.id}").find('.delete_link').click
      end
    end

    it { expect(current_path).to eq admin_interested_topics_path }
    it { expect(page).not_to have_content(tag.name) }
    it { expect { topic.reload }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
