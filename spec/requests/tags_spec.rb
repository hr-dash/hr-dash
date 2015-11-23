describe TagsController, type: :request do
  describe 'GET /tags' do
    describe 'return fixed tags' do
      let!(:tags) { create_list(:tag, 3, :fixed) }
      before { get tags_path, nil, headers_for_json }

      it { expect(response).to be_success }
      it { expect(JSON.parse(response.body).size).to eq 3 }
    end

    describe 'return only fixed tag' do
      let!(:fixed) { create(:tag, :fixed) }
      let!(:unfixed) { create(:tag, :unfixed) }
      before { get tags_path, nil, headers_for_json }

      it { expect(JSON.parse(response.body).size).to eq 1 }
      it { expect(JSON.parse(response.body).first["name"]).to eq fixed.name }
    end
  end
end
