describe PasswordResetsController, type: :feature do
  describe '#create' do
    let(:email) { user.email }

    before do
      visit new_password_reset_path
      fill_in 'email', with: email
      click_on 'Submit'
    end

    context 'request by valid user' do
      let(:user) { create(:user) }
      it { expect(user.reload.reset_password_token).not_to be nil }
      it { expect(page.body).to have_content('パスワード再設定用のURLが送信されました') }
    end

    context 'request by retired_user' do
      let(:user) { create(:user, deleted_at: Time.current.yesterday) }
      it { expect(user.reload.reset_password_token).to be nil }
      it { expect(page.body).to have_content('有効なメールアドレスではありません') }
    end

    context 'request by not_registered_user' do
      let(:user) { build(:user) }
      it { expect(page.body).to have_content('有効なメールアドレスではありません') }
    end

    context 'request by email blank' do
      let(:email) { '' }
      it { expect(page.body).to have_content('有効なメールアドレスではありません') }
    end
  end

  describe '#update' do
    let(:user) { create(:user) }
    let!(:original_token) { user.send_reset_password_instructions }
    let(:new_password) { generate_random_password }
    let(:password_confirmation) { new_password }
    let(:token) { original_token }

    before do
      visit edit_password_reset_path(user, reset_password_token: token)
      fill_in 'new password', with: new_password
      fill_in 'new password (confirmation)', with: password_confirmation
      click_on 'Change Password'
    end

    context 'valid reset_token' do
      it { expect(user.reload.reset_password_token).to be nil }
      it { expect(page.body).to have_content('パスワードが変更されました') }
    end

    context 'invalid reset_token' do
      let(:token) { Faker::Lorem.word }
      it { expect(user.reload.reset_password_token).not_to be nil }
      it { expect(page.body).to have_content('不正な値です') }
    end

    context 'differ between new_password and its confirmation' do
      let(:password_confirmation) { generate_random_password }
      it { expect(user.reload.reset_password_token).not_to be nil }
      it { expect(page.body).to have_content('パスワードの入力が一致しません') }
    end
  end
end
