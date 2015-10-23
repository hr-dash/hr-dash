require 'rails_helper'

describe SampleController, type: :request do
  describe 'GET /sample' do
    before { get sample_index_path }
    it { expect(response).to be_success }
  end
end
