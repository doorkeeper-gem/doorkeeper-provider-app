RSpec.describe Api::V1::FastController do
  describe 'GET #index' do
    let(:token) { double(accessible?: true, acceptable?: true, revoked?: false, expired?: false) }

    before do
      allow(controller).to receive(:doorkeeper_token) { token }
    end

    it 'responds with 200' do
      get :index, format: :json
      expect(response.status).to eq(200)
    end

    it 'returns recent profiles as json' do
      get :index, format: :json
      expect(response.body).to eq({ :ok => true }.to_json)
    end

    it 'responds with 401 when unauthorized' do
      allow(token).to receive_messages accessible?: false
      allow(token).to receive_messages acceptable?: false
      get :index, format: :json
      expect(response.status).to eq(401)
    end
  end
end
