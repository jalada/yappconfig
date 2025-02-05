require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../dummy/config/environment.rb",  __FILE__)

require 'app-config/railtie'

RSpec.describe "AppConfig with Rails" do

  before do
    ActiveSupport.run_load_hooks(:before_configuration)
  end

  it "Should default to the Rails environment" do
    expect(AppConfig.configuration.environment).to eq Rails.env
  end

  it "Should default to Rails.root/config/config.yml" do
    expect(AppConfig.configuration.config_file).to eq Rails.root.join("config/config.yml")
  end

  it "Auto reloads if the Rails environment is development" do
    Rails.env = "development"
    AppConfig::Railtie.initializers.map{|i| i.run}
    expect(AppConfig.configuration.auto_reload).to eq true
  end

  it "Doesn't auto-reload if the Rails environment is production" do
    Rails.env = "production"
    ActiveSupport.run_load_hooks(:before_configuration)

    AppConfig::Railtie.initializers.map{|i| i.run}
    expect(AppConfig.configuration.auto_reload).to eq false
  end
end
