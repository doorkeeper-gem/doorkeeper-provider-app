# frozen_string_literal: true

require_relative 'boot'

# Require Rails components
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
# require 'active_job/railtie'
# require 'action_cable/engine'
# require 'rails/test_unit/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DoorkeeperProvider
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.to_prepare do
      # Only Applications list
      Doorkeeper::ApplicationsController.layout 'application'

      # Only Authorization endpoint
      # Doorkeeper::AuthorizationsController.layout 'application'

      # Only Authorized Applications
      # Doorkeeper::AuthorizedApplicationsController.layout 'application'
    end
  end
end
