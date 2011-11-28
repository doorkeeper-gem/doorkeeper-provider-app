class Api::V1::ProfilesController < ApplicationController
  doorkeeper_for :all

  respond_to :json

  def index
    respond_with Profile.all
  end
end
