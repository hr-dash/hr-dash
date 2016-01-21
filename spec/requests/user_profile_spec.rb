describe UserProfilesController, type: :request do
  let(:profile) { create :user_profile }
  before { login profile.user }

  describe '#edit GET /user_profiles/:id/edit' do
    before { get edit_user_profile_path(id: profile.user.id) }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template 'user_profiles/edit' }
  end
end
