describe UserProfilesController, type: :request do
  let(:user) { create :user }
  let(:profile) { user.user_profile }

  describe '#show GET /user_profiles/:id' do
    before { login user }

    context 'valid' do
      before { get user_profile_path(profile) }
      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template 'user_profiles/show' }
      it { expect(response.body).to match user.name }
      it { expect(response.body).to match user.group.name }
      it { expect(response.body).to match user.employee_code.to_s }
      it { expect(response.body).to match user.email }
      it { expect(response.body).to match user.entry_date.to_s }
      it { expect(response.body).to match profile.gender_i18n }
      it { expect(response.body).to match profile.blood_type_i18n }
      it { expect(response.body).to match profile.birthday.to_s }
      it { expect(response.body).to match 'プロフィール編集' }
    end

    context 'valid login user except profile owner' do
      let(:other_user) { create :user }
      let(:other_user_profile) { other_user.user_profile }
      before do
        login other_user
        get user_profile_path(profile)
      end
      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template 'user_profiles/show' }
      it { expect(response.body).to match user.name }
      it { expect(response.body).to match user.group.name }
      it { expect(response.body).to match user.employee_code.to_s }
      it { expect(response.body).to match user.email }
      it { expect(response.body).to match user.entry_date.to_s }
      it { expect(response.body).to match profile.gender_i18n }
      it { expect(response.body).to match profile.blood_type_i18n }
      it { expect(response.body).to match profile.birthday.to_s }
      it { expect(response.body).not_to match 'プロフィール編集' }
    end

    context 'valid without group_id' do
      let(:user) { create(:user, group_id: nil) }
      before { get user_profile_path(user.user_profile) }
      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template 'user_profiles/show' }
    end

    context 'valid without birthday' do
      let(:user) do
        create(:user) { |u| u.user_profile.birthday = nil }
      end

      before { get user_profile_path(user.user_profile) }
      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template 'user_profiles/show' }
    end

    context 'not_found' do
      let(:not_found_id) { 0 }
      before { get user_profile_path(id: not_found_id) }
      it { expect(response).to have_http_status :not_found }
      it { expect(response).to render_template 'errors/404' }
    end
  end

  describe '#edit GET /user_profiles/:id/edit' do
    let(:user_id) { profile.user_id }

    context 'valid' do
      before do
        login profile.user
        get edit_user_profile_path(profile)
      end

      it { expect(response).to have_http_status :success }
      it { expect(response).to render_template 'user_profiles/edit' }
    end

    context 'invalid' do
      let(:other_user) { create(:user) }
      before do
        login other_user
        get edit_user_profile_path(profile)
      end

      it { expect(response).to have_http_status :not_found }
    end

    context 'not found' do
      let(:profile_id) { 0 }
      before do
        login profile.user
        get edit_user_profile_path(id: profile_id)
      end

      it { expect(response).to have_http_status :not_found }
    end
  end

  describe '#update PATCH /user_profiles/:id' do
    let(:new_profile) { attributes_for(:user_profile) }
    let(:profile_params) { new_profile }
    let(:patch_params) { { user_profile: profile_params } }

    context 'valid' do
      before do
        login profile.user
        patch user_profile_path(profile, patch_params)
      end

      it { expect(response).to have_http_status :redirect }
      it { expect(response).to redirect_to user_profile_path(user.user_profile) }
    end

    context 'invalid' do
      let(:other_user) { create(:user) }
      before do
        login other_user
        patch user_profile_path(profile, patch_params)
      end

      it { expect(response).to have_http_status :not_found }
    end

    context 'not_found' do
      let(:profile_id) { 0 }
      before do
        login profile.user
        patch user_profile_path(profile_id, patch_params)
      end

      it { expect(response).to have_http_status :not_found }
    end
  end
end
