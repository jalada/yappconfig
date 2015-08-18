require 'rails'

module AppConfig
  class Railtie < Rails::Railtie
    config.before_configuration do

      # AppConfig can be used in conjunction with dotenv, and as per their
      # code, we are running `.load` ahead of them.
      if defined?(Dotenv::Railtie) && Dotenv::Railtie.respond_to?(:load)
        Dotenv::Railtie.load
      end

      AppConfig.configure do |config|
        config.config_file = Rails.root.join("config", "config.yml")
        config.environment = Rails.env
        config.auto_reload = true if Rails.env == "development"
      end
    end
  end

end
