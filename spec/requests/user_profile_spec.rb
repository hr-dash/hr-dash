describe UserProfilesController, type: :request do
  let!(:profile) { create :user_profile }
  before { login profile.user }

  describe '#new GET /user_profiles/new' do
    before { get new_user_profile_path }
    it { expect(response).to have_http_status :success }
    it { expect(response).to render_template('user_profiles/new') }
    it { expect(response.body).to match profile.user.name }
  end

  describe '#edit GET /user_profiles/:id/edit' do
    let(:user_id) { profile.user_id }

    context 'valid' do
      before do
        login profile.user
        get edit_user_profile_path(id: user_id)
      end

      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template 'user_profiles/edit' }
    end

    context 'invalid' do
      let(:invalid_user_id) { user_id + 1 }
      before do
        login profile.user
        get edit_user_profile_path(id: invalid_user_id)
      end

      it { expect(response).to have_http_status :redirect }
      it { expect(response).to redirect_to root_path }
    end

    context 'not found' do
      let(:user) { create :user }
      before do
        login user
        get edit_user_profile_path(id: user.id)
      end

      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template 'errors/404' }
    end
  end
end
