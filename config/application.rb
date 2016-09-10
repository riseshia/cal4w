require_relative "boot"

require "sprockets/es6"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cal4w
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over
    # those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record
    # auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    config.time_zone = "UTC"

    config.autoload_paths << Rails.root.join("lib")
    config.autoload_paths << Rails.root.join("app/forms")

    config.eager_load_paths << Rails.root.join("lib")
  end
end
