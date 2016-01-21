describe Admin::DashboardController, type: :request do
  let(:user) { create :user }
  let!(:role) { create :user_role, user: user, admin: admin_flag }
  before { login user }

  describe 'can login to active_admin only admin role' do
    before { get admin_root_path }

    context 'admin user' do
      let(:admin_flag) { true }
      it { expect(response).to have_http_status :success }
      it { expect(response.body).to match 'ダッシュボード' }
    end

    context 'not admin user' do
      let(:admin_flag) { false }
      it { expect(response).to have_http_status :redirect }
      it { expect(response.body).not_to match 'ダッシュボード' }
    end
  end
end
