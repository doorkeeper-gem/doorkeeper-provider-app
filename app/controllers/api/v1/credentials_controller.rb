# frozen_string_literal: true

module Api::V1
  class CredentialsController < ApiController
    before_action :doorkeeper_authorize!

    def me
      render json: current_resource_owner
    end

    def zapier
      render json: { message: 'Zapier POC successful'}
    end
  end
end
