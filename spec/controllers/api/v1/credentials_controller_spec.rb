RSpec.describe Api::V1::CredentialsController do
  describe 'GET #me (integrated)', :type => :request do
    let!(:application) { Doorkeeper::Application.create!(name: 'MyApp', redirect_uri: 'https://app.com') }
    let!(:user) { User.create!(email: 'ax@b.com', password: 'abc123', password_confirmation: 'abc123') }
    let!(:token) { Doorkeeper::AccessToken.create!(application_id: application.id, resource_owner_id: user.id, scopes: 'public') }

    it 'responds with 200' do
      get api_v1_me_url, headers: {
        'Authorization' => "Bearer #{token.token}"
      }
      expect(response.status).to eq(200)
    end

    it 'returns the user as json' do
      get api_v1_me_url, headers: {
        'Authorization' => "Bearer #{token.token}"
      }
      expect(response.body).to eq(user.to_json)
    end
  end

  describe 'GET #me (stubbed)' do
    let(:token) { double(token: 'some-token', accessible?: true, acceptable?: true, revoked?:false, expired?: false) }
    let(:user)  { double(to_json: '{}') }

    before do
      allow(controller).to receive(:doorkeeper_token) { token }
      allow(controller).to receive(:current_resource_owner) { user }
    end

    it 'responds with 200' do
      get :me, format: :json
      expect(response.status).to eq(200)
    end

    it 'responds with 401 when unauthorized' do
      allow(token).to receive_messages accessible?: false
      allow(token).to receive_messages acceptable?: false
      get :me, format: :json
      expect(response.status).to eq(401)
    end

    it 'returns the user as json' do
      get :me, format: :json
      expect(response.body).to eq(user.to_json)
    end
  end
end
