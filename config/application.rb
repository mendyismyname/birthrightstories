require File.expand_path('../boot', __FILE__)

require 'rails/all'

# These needed to load the config.yml
require File.expand_path('../config_loader', __FILE__)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BirthrightStories
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de


    # Load models from subdirectories too
    config.autoload_paths += Dir[Rails.root.join('app', 'workers')]
    config.autoload_paths += Dir[Rails.root.join('app', 'mappers')]
    config.autoload_paths += Dir[Rails.root.join('app', 'services')]
  
    # Read the config from the config.yml
    config.environment_app_config = ConfigLoader.load_app_config

  end
end
