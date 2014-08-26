module Api::V1
  class UsersController < ApiController
    before_action -> { doorkeeper_authorize! :public }, :only => :index
    before_action only: [:create, :update, :destroy] do
      doorkeeper_authorize! :write
    end

    def index
      respond_with User.recent
    end

    def create
      respond_with 'api_v1', User.create!(params[:user])
    end
  end
end
