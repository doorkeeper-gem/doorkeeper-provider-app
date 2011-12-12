module Api::V1
  class ProfilesController < ApiController
    doorkeeper_for :all

    respond_to :json

    def index
      respond_with Profile.limit(5).order('updated_at desc')
    end

    def create
      Profile.create!(params[:profile])
    end
  end
end
