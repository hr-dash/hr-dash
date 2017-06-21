# frozen_string_literal: true
describe UserProfilesController, type: :feature do
  before { login }

  describe '#index GET /user_profiles' do
    context 'by user_name' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }
      let!(:user) { create(:user, name: '山田太郎', entry_date: 1.months.ago) }
      let!(:user_profile) { create(:user_profile, user: user) }

      before do
        visit user_profiles_path
        fill_in '氏名', with: '山田太郎'
        click_button '検索'
      end

      it { expect(current_path).to eq user_profiles_path }
      it { expect(page).to have_selector 'div', text: '山田太郎' }
      it { expect(page).not_to have_selector 'div', text: 'やまだたろう' }
    end

    context 'by self_introduction' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }
      let!(:user) { create(:user, name: '山田太郎', entry_date: 1.months.ago) }
      let!(:user_profile) { create(:user_profile, user: user, self_introduction: 'Rubyが得意です。') }

      before do
        visit user_profiles_path
        fill_in '自己紹介', with: 'Ruby'
        click_button '検索'
      end

      it { expect(current_path).to eq user_profiles_path }
      it { expect(page).to have_selector 'div', text: '山田太郎' }
      it { expect(page).not_to have_selector 'div', text: 'やまだたろう' }
    end

    context 'by user_entry_date_from' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }
      let!(:junior_user) { create(:user, entry_date: Date.new(2016, 4, 1)) }
      let!(:middle_user) { create(:user, entry_date: Date.new(2015, 4, 1)) }
      let!(:senior_user) { create(:user, entry_date: Date.new(2014, 4, 1)) }
      let!(:junior_user_profile) { create(:user_profile, user: junior_user) }
      let!(:middle_user_profile) { create(:user_profile, user: middle_user) }
      let!(:senior_user_profile) { create(:user_profile, user: senior_user) }

      before do
        visit user_profiles_path
        select 2015, from: 'entry_year_start'
        select 3, from: 'entry_month_start'
        click_button '検索'
      end

      it { expect(current_path).to eq user_profiles_path }
      it { expect(page).to have_selector 'small', text: '2016年04月01日入社' }
      it { expect(page).to have_selector 'small', text: '2015年04月01日入社' }
      it { expect(page).not_to have_selector 'small', text: '2014年04月01日入社' }
    end

    context 'by user_entry_date_to' do
      let(:url) { URI.parse(current_url) }
      let(:query) { URI.decode(url.query) }
      let!(:junior_user) { create(:user, entry_date: Date.new(2016, 4, 1)) }
      let!(:middle_user) { create(:user, entry_date: Date.new(2015, 4, 1)) }
      let!(:senior_user) { create(:user, entry_date: Date.new(2014, 4, 1)) }
      let!(:junior_user_profile) { create(:user_profile, user: junior_user) }
      let!(:middle_user_profile) { create(:user_profile, user: middle_user) }
      let!(:senior_user_profile) { create(:user_profile, user: senior_user) }

      before do
        visit user_profiles_path
        select 2015, from: 'entry_year_end'
        select 6, from: 'entry_month_end'
        click_button '検索'
      end

      it { expect(current_path).to eq user_profiles_path }
      it { expect(page).not_to have_selector 'small', text: '2016年04月01日入社' }
      it { expect(page).to have_selector 'small', text: '2015年04月01日入社' }
      it { expect(page).to have_selector 'small', text: '2014年04月01日入社' }
    end
  end
end
