require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Framework
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.



    class MyInflector < Zeitwerk::Inflector
      def camelize(*args)
        puts args
        super
      end
    end
    loader = Zeitwerk::Loader.new

    loader.push_dir Rails.root.join("../apps/admin/app/controllers")
    loader.setup
    loader.log!
    loader.inflector = MyInflector.new

    paths["config/routes.rb"].concat(Dir[Rails.root.join("..", "apps", "*", "config/routes.rb")].sort)
  end
end
