class Api::V1::ProfilesController < ApplicationController
  respond_to :json

  def index
    respond_with Profile.all
  end
end
