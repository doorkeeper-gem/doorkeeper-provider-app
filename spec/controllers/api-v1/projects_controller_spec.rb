# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ProjectsController do
  let(:user) { create :user }
  let(:project) { create :project, user: user }
  let(:token) { create :access_token, resource_owner_id: user.id }

  describe "GET :show" do
    context "with no :read access" do
      it "responds with 403" do
        get :show, params: { id: project.id, access_token: token.token }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "with :read access" do
      before { token.update(scopes: "read") }

      it "responds with 200" do
        get :show, params: { id: project.id, access_token: token.token }
        expect(response).to have_http_status(:ok)
      end

      it "returns the user as json" do
        get :show, params: { id: project.id, access_token: token.token }
        expect(response.body).to eq project.to_json
      end
    end
  end

  describe "POST :create" do
    let(:project) { attributes_for :project }

    context "with :read access" do
      it "responds with 403" do
        post :create, params: { project: project, access_token: token.token }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "with :write access" do
      before { token.update(scopes: "write") }

      it "responds with 200" do
        post :create, params: { project: project, access_token: token.token }
        expect(response).to have_http_status(:ok)
      end

      it "returns the user as json" do
        post :create, params: { project: project, access_token: token.token }
        expect(json_response).to include "name" => project[:name]
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
