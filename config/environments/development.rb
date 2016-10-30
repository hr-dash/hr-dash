Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # deviseの設定

  # Bulletの設定
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true # JavaScript alert in browser
    Bullet.console = true # Warning to JavaScript console
    Bullet.bullet_logger = true # Rails.root/log/bullet.log
    Bullet.rails_logger = true # Add warning to rails_log
    Bullet.unused_eager_loading_enable = false
  end

  # Mailer Configration
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.default_options = { from: "システム管理者 <#{ENV['MAILER_FROM']}>" }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:               ENV['MAILER_ADDRESS'],
    port:                  ENV['MAILER_PORT'],
    domain:                ENV['MAILER_DOMAIN'],
    user_name:             ENV['MAILER_USERNAME'],
    password:              ENV['MAILER_PASSWORD'],
    authentication:        'plain',
    enable_starttls_auto:  true
  }

  config.cache_store = :redis_store, ENV['REDIS_URL'], { expires_in: 30.minutes }
end
