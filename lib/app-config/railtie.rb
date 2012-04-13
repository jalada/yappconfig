require 'rails'

module AppConfig
  class Railtie < Rails::Railtie

    initializer "app-config.configure_for_rails" do
      AppConfig.configure do |config|
        config.config_file = Rails.root.join("config", "config.yml")
        config.environment = Rails.env
      end
    end
  end

end
