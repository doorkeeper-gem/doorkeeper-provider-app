# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User registrations" do
  let(:password) { "test123" }

  def sign_in_as(user)
    post user_session_path, params: { user: { email: user.email, password: password } }
  end

  describe "POST /users" do
    it "allows to sign up" do
      expect do
        post user_registration_path, params: {
          user: { email: "new@example.com", password: password, password_confirmation: password }
        }
      end.to change(User, :count).by(1)
    end
  end

  context "when signed in as the seed user" do
    let!(:user) { create :user, email: User::SEED_EMAIL }

    before { sign_in_as(user) }

    it "does not update the account" do
      put user_registration_path, params: {
        user: { email: "changed@example.com", password: "changed123",
                password_confirmation: "changed123", current_password: password }
      }

      expect(response).to redirect_to(edit_user_registration_path)
      expect(flash[:alert]).to be_present
      expect(user.reload.email).to eq User::SEED_EMAIL
      expect(user.valid_password?(password)).to be true
    end

    it "does not delete the account" do
      expect { delete user_registration_path }.not_to change(User, :count)

      expect(response).to redirect_to(edit_user_registration_path)
      expect(flash[:alert]).to be_present
    end
  end

  context "when signed in as a regular user" do
    let!(:user) { create :user }

    before { sign_in_as(user) }

    it "updates the account" do
      put user_registration_path, params: {
        user: { email: "changed@example.com", current_password: password }
      }

      expect(user.reload.email).to eq "changed@example.com"
    end

    it "deletes the account" do
      expect { delete user_registration_path }.to change(User, :count).by(-1)
    end
  end
end
