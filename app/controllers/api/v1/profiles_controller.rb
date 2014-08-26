module Api::V1
  class ProfilesController < ApiController
    before_action -> { doorkeeper_authorize! :public }, :only => :index
    before_action only: [:create, :update, :destroy] do
      doorkeeper_authorize! :write
    end

    def index
      render json: Profile.recent
    end

    def create
      profile = Profile.create!(profile_params)
      response.status = :created
      render json: { api_version: 'api_v1', profile: profile }
    end

    ###
    private
    ###

    def profile_params
      profile_params = params[:profile]
      profile_params ? profile_params.permit(:name, :email, :username) : {}
    end
  end
end
