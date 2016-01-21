describe UserProfilesController, type: :request do
  let(:user) { create(:user) }
  before { login user }

  describe '#new GET /user_profiles/new' do
    before { get new_user_profile_path }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template('user_profiles/new') }
    it { expect(response.body).to match user.name }
  end
end
