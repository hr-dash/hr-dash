describe UserProfilesController, type: :request do
  let(:profile) { create :user_profile }
  before { login profile.user }

  describe '#new GET /user_profiles/new' do
    before { get new_user_profile_path }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template('user_profiles/new') }
    it { expect(response.body).to match profile.user.name }
  end

  describe '#edit GET /user_profiles/:id/edit' do
    before { get edit_user_profile_path(id: profile.user.id) }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template 'user_profiles/edit' }
  end
end
