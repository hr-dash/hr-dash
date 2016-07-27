describe SessionsController, type: :feature do
  describe '#new GET /sessions/new' do
    describe 'success' do
      before { visit new_session_path }
      it { expect(page).to have_http_status :success }
    end

    describe "redirect this if user hasn't login" do
      before { visit root_path }
      it { expect(current_path).to eq(new_session_path) }
    end
  end

  describe '#create POST /sessions' do
    let(:session_id) { page.get_rack_session['session_id'] }

    before do
      @session_id_before = page.get_rack_session['session_id']
      visit new_session_path
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_on 'Login'
    end

    context 'valid user' do
      let(:user) { create :user }

      it { expect(page).to have_http_status :success }
      it { expect(session_id).not_to eq(@session_id_before) }
      it { expect(current_path).to eq(root_path) }
      it { expect(page.body).to have_content(user.name) }
    end

    context 'invalid user' do
      let(:user) { build :user }

      it { expect(page).to have_http_status :success }
      it { expect(session_id).not_to eq(@session_id_before) }
      it { expect(current_path).to eq(new_session_path) }
    end
  end

  describe '#destroy DELETE /sessions/destroy' do
    let(:user) { create(:user) }
    before do
      login user
      visit root_path
      click_on 'ログアウト'
    end

    it { expect(page).to have_http_status :success }
    it { expect(current_path).to eq(new_session_path) }
    it { expect(page.body).not_to have_content(user.name) }
  end
end
