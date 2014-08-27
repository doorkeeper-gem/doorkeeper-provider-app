require 'spec_helper'

describe Api::V1::ProfilesController do
  describe 'GET #index' do
    let(:token) { stub(:accessible? => true, :acceptable? => true, :revoked? => false, :expired? => false) }

    before do
      controller.stub(:doorkeeper_token) { token }
    end

    it 'responds with 200' do
      get :index, :format => :json
      response.status.should eq(200)
    end

    it 'returns recent profiles as json' do
      Profile.should_receive(:recent) { [] }
      get :index, :format => :json
      response.body.should == [].to_json
    end

    it 'responds with 401 when unauthorized' do
      token.stub :accessible? => false
      token.stub :acceptable? => false
      get :index, :format => :json
      response.status.should eq(401)
    end
  end

  describe 'POST #create (with scopes)' do
    let(:token) do
      stub :accessible? => true, :scopes => [:write],
         :acceptable? => true, :expired? => false, :revoked? => false
    end

    before do
      controller.stub(:doorkeeper_token) { token }
    end

    it 'creates the profile' do
      Profile.should_receive(:create!) { stub_model(Profile) }
      post :create, :format => :json
      response.status.should eq(201)
    end
  end
end
