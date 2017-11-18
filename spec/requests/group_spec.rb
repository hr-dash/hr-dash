# frozen_string_literal: true

describe GroupsController, type: :request do
  before { login }

  describe '#index GET groups' do
    let!(:user) { create(:user) }
    let(:group) { user.groups.first }
    before { get groups_path }

    it { expect(response).to have_http_status :success }
    it { expect(response.body).to match user.name }
    it { expect(response.body).to match group.name }
    it { expect(response.body).to match group.description }
  end
end
