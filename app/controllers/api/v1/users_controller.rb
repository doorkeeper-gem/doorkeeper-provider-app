module Api::V1
  class UsersController < ApiController
    doorkeeper_for :index
    doorkeeper_for :create, :scopes => [:write]

    respond_to :json

    def index
      respond_with User.recent
    end

    def create
      respond_with 'api_v1', User.create!(params[:user])
    end
  end
end
