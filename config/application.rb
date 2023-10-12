require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DoorkeeperProvider
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.to_prepare do
      # Only Applications list
      Doorkeeper::ApplicationsController.layout 'application'

      # Only Authorization endpoint
      # Doorkeeper::AuthorizationsController.layout 'application'

      # Only Authorized Applications
      # Doorkeeper::AuthorizedApplicationsController.layout 'application'
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.i18n.default_locale = :'fr'
    config.i18n.fallbacks = [:en]
  end
end
