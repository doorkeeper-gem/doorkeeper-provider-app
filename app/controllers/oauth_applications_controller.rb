# frozen_string_literal: true

class OauthApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application, only: %i[show edit update destroy]
  before_action :forbid_seed_user_changes, only: %i[update destroy]

  def index
    @applications = current_user.oauth_applications.ordered_by(:created_at)
  end

  def show
  end

  def new
    @application = current_user.oauth_applications.new
  end

  def create
    @application = current_user.oauth_applications.new(application_params)

    if @application.save
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications create])
      redirect_to oauth_application_url(@application)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @application.update(application_params)
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications update])
      redirect_to oauth_application_url(@application)
    else
      render :edit
    end
  end

  def destroy
    if @application.destroy
      flash[:notice] = I18n.t(:notice, scope: %i[doorkeeper flash applications destroy])
    end

    redirect_to oauth_applications_url
  end

  private

    def set_application
      @application = current_user.oauth_applications.find(params[:id])
    end

    # The applications of the seed user are configured in the demo clients,
    # and anyone can sign in as that user. Keep them intact for other
    # visitors of the demo.
    def forbid_seed_user_changes
      return unless current_user.seed?

      redirect_to oauth_application_url(@application),
                  alert: "The applications of the demo user cannot be changed or deleted."
    end

    def application_params
      params.require(:doorkeeper_application).permit(:name, :redirect_uri, :scopes, :confidential)
    end
end
