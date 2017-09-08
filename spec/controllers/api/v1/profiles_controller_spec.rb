RSpec.describe Api::V1::ProfilesController do
  describe 'GET #index' do
    let(:token) { double(:accessible? => true, :acceptable? => true, :revoked? => false, :expired? => false) }

    before do
      allow(controller).to receive(:doorkeeper_token) { token }
    end

    it 'responds with 200' do
      get :index, :format => :json
      expect(response.status).to eq(200)
    end

    it 'returns recent profiles as json' do
      expect(Profile).to receive(:recent) { [] }
      get :index, :format => :json
      expect(response.body).to eq([].to_json)
    end

    it 'responds with 401 when unauthorized' do
      allow(token).to receive_messages :accessible? => false
      allow(token).to receive_messages :acceptable? => false
      get :index, :format => :json
      expect(response.status).to eq(401)
    end
  end

  describe 'POST #create (with scopes)' do
    let(:token) do
      double :accessible? => true, :scopes => [:write],
         :acceptable? => true, :expired? => false, :revoked? => false
    end

    before do
      allow(controller).to receive(:doorkeeper_token) { token }
    end

    it 'creates the profile' do
      expect(Profile).to receive(:create!) { instance_double(Profile) }
      post :create, :format => :json
      expect(response.status).to eq(201)
    end
  end
end
