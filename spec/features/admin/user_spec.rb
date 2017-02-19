describe 'Admin::User', type: :feature do
  before { login(user, admin: true) }
  let(:user) { create(:user) }
  let(:page_title) { find('#page_title') }

  describe '#index' do
    before { visit admin_users_path }
    it { expect(page_title).to have_content('ユーザ') }
    it { expect(page).to have_content(user.name) }
    it { expect(page).not_to have_css('.delete_link') }
  end

  describe '#show' do
    before { visit admin_user_path(user) }
    it { expect(page_title).to have_content(user.name) }
    it { expect(page).to have_content('PW変更') }
  end

  describe '#create' do
    let(:user_params) { build(:user) }
    let(:created_user) { User.last }
    before do
      visit new_admin_user_path
      fill_in '名前', with: user_params.name
      select user_params.gender, from: '性別'
      fill_in '社員番号', with: user_params.employee_code
      fill_in 'メールアドレス', with: user_params.email
      fill_in '入社日', with: user_params.entry_date
      check 'user_beginner_flg' if user_params.beginner_flg
      click_on 'ユーザーを作成'
    end

    it { expect(current_path).to eq admin_user_path(created_user) }
    it { expect(user_params.name).to eq created_user.name }
    it { expect(user_params.gender).to eq created_user.gender }
    it { expect(user_params.employee_code).to eq created_user.employee_code }
    it { expect(user_params.email).to eq created_user.email }
    it { expect(user_params.entry_date).to eq created_user.entry_date }
    it { expect(user_params.beginner_flg).to eq created_user.beginner_flg }
  end

  describe '#update' do
    let(:new_name) { Faker::Name.name }
    before do
      visit edit_admin_user_path(user)
      fill_in '名前', with: new_name
      click_on 'ユーザーを更新'
    end

    it { expect(page_title).to have_content(new_name) }
    it { expect(user.reload.name).to eq new_name }
    it { expect(current_path).to eq admin_user_path(user) }
  end

  describe '#import_csv' do
    before { visit input_csv_admin_users_path }

    context 'no input csv file' do
      before { click_on 'インポートする' }

      it { expect(current_path).to eq input_csv_admin_users_path }
      it { expect(page).to have_content('CSVファイルを指定してください') }
    end

    context 'input valid csv file' do
      let(:file) { File.join(fixture_path, 'users.csv') }
      let(:yamada) { User.find_by(name: '山田 太郎') }
      let(:suzuki) { User.find_by(name: '鈴木 花子') }

      before do
        attach_file 'csv', file
        click_on 'インポートする'
      end

      it { expect(current_path).to eq admin_users_path }
      it { expect(page).to have_content('2名のユーザーがインポートされました') }
      it { expect(yamada).to be_present }
      it { expect(yamada.email).to eq 'yamada.taro@example.com' }
      it { expect(yamada.gender).to eq 'male' }
      it { expect(yamada.beginner_flg).to eq true }
      it { expect(yamada.user_profile).to be_present }
      it { expect(suzuki).to be_present }
      it { expect(suzuki.email).to eq 'suzuki.hanako@example.com' }
      it { expect(suzuki.gender).to eq 'female' }
      it { expect(suzuki.beginner_flg).to eq false }
      it { expect(suzuki.user_profile).to be_present }
    end
  end

  describe '#update_password' do
    let(:other_user) { create(:user) }
    let(:new_password) { generate_random_password }
    before do
      visit edit_password_admin_user_path(other_user)
      fill_in 'パスワード', with: new_password
      fill_in 'パスワード（確認）', with: new_password
      click_on '更新する'
    end

    it { expect(current_path).to eq admin_users_path }
    it { expect(page_title).to have_content('ユーザー') }
    it { expect(other_user.reload.valid_password?(new_password)).to be true }
  end

  describe '#delete_monthly_report', js: true do
    let!(:report) { create(:monthly_report, :with_comments, :with_tags, user: target_user) }

    context 'retired user reports' do
      let(:target_user) { create(:user, deleted_at: Time.current) }
      let(:tags) { MonthlyReportTag.where(monthly_report_id: report.id) }
      let(:comments) { MonthlyReportComment.where(monthly_report_id: report.id) }
      let(:working_process) { MonthlyWorkingProcess.where(monthly_report_id: report.id) }
      before do
        visit admin_user_path(target_user)
        accept_confirm { click_link('月報を削除する') }
      end

      xit { expect(page).to have_content('月報を削除する') }
      it { expect(target_user.monthly_reports).to be_blank }
      it { expect(tags).to be_blank }
      it { expect(comments).to be_blank }
      it { expect(working_process).to be_blank }
    end

    context 'not retired user reports' do
      let(:target_user) { create(:user) }
      before do
        visit admin_user_path(target_user)
      end

      it { expect(page).not_to have_content('月報を削除する') }
    end
  end

  describe 'cannot access if operator' do
    let(:operator) { create(:user) }

    before do
      login(operator, operator: true)
      visit admin_users_path
    end

    it { expect(current_path).to eq admin_root_path }
  end
end
