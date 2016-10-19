describe Admin::DashboardController, type: :request do
  let(:user) { create :user }
  let!(:user_role) { create :user_role, role, user: user }
  before { login user }

  describe 'can login to active_admin with admin or operator role' do
    before { get admin_root_path }

    context 'admin user' do
      let(:role) { :admin }
      it { expect(response).to have_http_status :success }
      it { expect(response.body).to match 'ダッシュボード' }
    end

    context 'operator user' do
      let(:role) { :operator }
      it { expect(response).to have_http_status :success }
      it { expect(response.body).to match 'ダッシュボード' }
    end

    context 'not admin user' do
      let!(:user_role) { } # don't create user_role
      it { expect(response).to have_http_status :redirect }
      it { expect(response.body).not_to match 'ダッシュボード' }
    end
  end
end
