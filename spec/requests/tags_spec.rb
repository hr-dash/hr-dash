describe TagsController, type: :request do
  describe 'GET /tags' do
    let!(:tags) { create_list(:tag, 3) }
    before { get tags_path, nil, headers_for_json }

    it { expect(response).to be_success }
    it { expect(JSON.parse(response.body).size).to eq 3 } 
  end
end
