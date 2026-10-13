# frozen_string_literal: true

require "rails_helper"

RSpec.describe "OAuth applications" do
  let(:password) { "test123" }
  let!(:application) { create :application, owner: user, redirect_uri: "https://client.example.com/callback" }

  def sign_in_as(user)
    post user_session_path, params: { user: { email: user.email, password: password } }
  end

  before { sign_in_as(user) }

  context "when signed in as the seed user" do
    let(:user) { create :user, email: User::SEED_EMAIL }

    it "does not update the application" do
      put oauth_application_path(application), params: {
        doorkeeper_application: { redirect_uri: "https://attacker.example.com/callback" }
      }

      expect(response).to redirect_to(oauth_application_path(application))
      expect(flash[:alert]).to be_present
      expect(application.reload.redirect_uri).to eq "https://client.example.com/callback"
    end

    it "does not delete the application" do
      expect { delete oauth_application_path(application) }.not_to change(Doorkeeper::Application, :count)

      expect(response).to redirect_to(oauth_application_path(application))
      expect(flash[:alert]).to be_present
    end
  end

  context "when signed in as a regular user" do
    let(:user) { create :user }

    it "updates the application" do
      put oauth_application_path(application), params: {
        doorkeeper_application: { redirect_uri: "https://changed.example.com/callback" }
      }

      expect(application.reload.redirect_uri).to eq "https://changed.example.com/callback"
    end

    it "deletes the application" do
      expect { delete oauth_application_path(application) }.to change(Doorkeeper::Application, :count).by(-1)
    end
  end
end
