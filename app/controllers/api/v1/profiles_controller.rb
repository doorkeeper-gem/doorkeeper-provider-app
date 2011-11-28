module Api::V1
  class ProfilesController < ApiController
    doorkeeper_for :all

    respond_to :json

    def index
      respond_with Profile.all
    end
  end
end
