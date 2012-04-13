require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../dummy/config/environment.rb",  __FILE__)

require 'app-config/railtie'

describe "AppConfig with Rails" do

  before :each do 
    AppConfig::Railtie.initializers.map{|i| i.run}
  end

  it "Should default to the Rails environment" do
    AppConfig.configuration.environment.should == Rails.env
  end

  it "Should default to Rails.root/config/config.yml" do
    AppConfig.configuration.config_file.should == Rails.root.join("config/config.yml")
  end


end
