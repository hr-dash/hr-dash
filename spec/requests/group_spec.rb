describe GroupsController, type: :request do
  before { login }

  describe '#index GET groups' do
    let!(:user) { create(:user) }
    before { get groups_path }

    it { expect(response).to have_http_status :success }
    it { expect(response.body).to match user.name }
    it { expect(response.body).to match user.group.name }
    it { expect(response.body).to match user.group.description }
  end
end
