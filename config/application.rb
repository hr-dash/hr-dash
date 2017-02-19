require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Dash
  class Application < Rails::Application
    config.name = 'Dash'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Tokyo'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja

    # Add custom validators path
    config.autoload_paths += Dir["#{config.root}/app/validators"]

    # Setting Generator command
    config.generators do |g|
        g.template_engine = :slim
        g.assets false
        g.helper false
    end

    config.action_dispatch.default_headers['X-Frame-Options'] = 'DENY'

    config.exceptions_app = ->(env) { ErrorsController.action(:show).call(env) }
    config.web_console.development_only = false
  end
end
