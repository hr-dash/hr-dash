describe SessionsController, type: :request do
  describe '#new GET /sessions/new' do
    describe 'success' do
      before { get new_session_path }
      it { expect(response).to have_http_status :success }
    end

    describe "redirect this if user hasn't login" do
      before { get root_path }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe '#create POST /sessions' do
    let(:login_params) { { user: { email: user.email, password: user.password } } }
    before { post sessions_path, login_params }

    context 'valid user' do
      let(:user) { create :user  }

      it { expect(response).to have_http_status :found }
      it { expect(response).to redirect_to(root_path) }
      it { expect(controller.current_user).not_to be nil }
    end

    context 'invalid user' do
      let(:user) { build :user  }

      it { expect(response).to have_http_status :found }
      it { expect(response).to redirect_to(new_session_path) }
    end
  end

  describe '#destroy DELETE /sessions/destroy' do
    let(:user) { create :user  }
    let(:login_params) { { user: { email: user.email, password: user.password } } }

    before do
      post sessions_path, login_params # login before test
      delete destroy_sessions_path
    end

    it { expect(response).to have_http_status :found }
    it { expect(response).to redirect_to(root_path) }
    it { expect(controller.current_user).to be nil }
  end
end
