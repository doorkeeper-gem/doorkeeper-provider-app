# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApiController
    before_action -> { doorkeeper_authorize! :read }, only: %i[index show]
    before_action -> { doorkeeper_authorize! :write }, only: %i[create update destroy]

    def index
      render json: current_resource_owner.projects
    end

    def show
      render json: current_resource_owner.projects.find(params[:id])
    end

    def create
      @project = current_resource_owner.projects.new(project_params)

      if @project.save
        render json: @project
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    def update
      @project = current_resource_owner.projects.find(params[:id])
      if @project.update(project_params)
        render json: @project
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @project.destroy
      render :ok
    end

    private

      def project_params
        params.require(:project).permit(:name, :url)
      end
  end
end
