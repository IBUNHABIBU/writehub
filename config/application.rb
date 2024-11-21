require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Railstarter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    config.assets.paths << Rails.root.join("app/assets/builds")
    config.assets.precompile += %w(application.css)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
        Geocoder.configure(
        timeout: 25,
        lookup: :google,
        api_key: ENV['GOOGLE_API'],
        ip_lookup: :ipinfo_io,    
        units: :km,           
        use_https: true,   
        http_headers: { 'Referer' => 'https://writehub.cyou' }
        )
  end
end
