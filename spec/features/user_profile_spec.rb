# frozen_string_literal: true
describe UserProfilesController, type: :feature do
  before { login }

  describe '#index GET /user_profiles' do
    context 'by user_name' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }

      before do
        visit user_profiles_path
        fill_in '氏名', with: '山崎真宏'
        click_button '検索'
      end

      it { expect(current_path).to eq user_profiles_path }
      it { expect(query).to include 'q[user_name_cont]=山崎真宏' }
      it { expect(query).not_to include 'q[user_name_cont]=やまざきまさひろ' }
    end

    context 'by self_introduction' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }

      before do
        visit user_profiles_path
        fill_in '自己紹介', with: 'Ruby'
        click_button '検索'
      end

      it { expect(current_path).to eq user_profiles_path }
      it { expect(query).to include 'q[self_introduction_cont]=Ruby' }
      it { expect(query).not_to include 'q[self_introduction_cont]=Java' }
    end

    context 'by blood_type' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }

      before do
        visit user_profiles_path
        select 'A型', from: 'q[blood_type_eq]'
        click_button '検索'
      end

      it { expect(current_path).to eq user_profiles_path }
      it { expect(query).to include 'q[blood_type_eq]=1' }
      it { expect(query).not_to include 'q[blood_type_eq]=2' }
    end

    context 'by user_entry_date' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }
      let!(:user) { create(:user, entry_date: 1.months.ago) }
      let!(:user_profile) { create(:user_profile, user: user) }
      let!(:first_1m_ago) { 1.months.ago.beginning_of_month }
      let!(:first_2m_ago) { 2.months.ago.beginning_of_month }

      before do
        visit user_profiles_path
        select first_1m_ago.strftime('%Y年%m月'), from: '入社日'
        click_button '検索'
      end

      it { expect(current_path).to eq user_profiles_path }
      it { expect(query).to include "q[user_entry_date_gteq]=#{first_1m_ago.to_date}" }
      it { expect(query).not_to include "q[user_entry_date_gteq]=#{first_2m_ago.to_date}" }
    end
  end
end
