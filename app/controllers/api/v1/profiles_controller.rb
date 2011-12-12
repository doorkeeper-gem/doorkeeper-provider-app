module Api::V1
  class ProfilesController < ApiController
    doorkeeper_for :index
    doorkeeper_for :create, :scopes => [:write]

    respond_to :json

    def index
      respond_with Profile.limit(5).order('updated_at desc')
    end

    def create
      Profile.create!(params[:profile])
    end
  end
end
