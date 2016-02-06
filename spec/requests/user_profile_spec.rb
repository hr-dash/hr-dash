describe UserProfilesController, type: :request do
  let!(:profile) { create :user_profile }
  before { login profile.user }

  describe '#show GET /user_profiles/:id' do
    context 'valid' do
      before { get user_profile_path(profile) }
      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template('user_profiles/show') }
      it { expect(response.body).to match profile.user.name }
      it { expect(response.body).to match profile.user.group.name }
      it { expect(response.body).to match profile.user.employee_code.to_s }
      it { expect(response.body).to match profile.user.email }
      it { expect(response.body).to match profile.user.entry_date.to_s }
      it { expect(response.body).to match profile.gender_i18n }
      it { expect(response.body).to match profile.blood_type_i18n }
      it { expect(response.body).to match profile.birthday.to_s }
    end

    context 'invalid' do
      let(:invalid_id) { profile.id + 1 }
      before { get user_profile_path(id: invalid_id) }
      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template 'errors/404' }
    end
  end

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
        get edit_user_profile_path(id: profile.id)
      end

      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template 'user_profiles/edit' }
    end

    context 'invalid' do
      let!(:profile) { create :user_profile }
      let(:invalid_id) { profile.id + 1 }
      before do
        login profile.user
        get edit_user_profile_path(id: invalid_id)
      end

      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template 'errors/404' }
    end

    context 'not found' do
      let(:user) { create :user }
      let(:profile_id) { 0 }
      before do
        login user
        get edit_user_profile_path(id: profile_id)
      end

      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template 'errors/404' }
    end
  end
end
