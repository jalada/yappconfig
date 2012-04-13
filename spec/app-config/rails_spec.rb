require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "AppConfig with Rails" do
  before(:each) do
    AppConfig::Rails = Object.new
    AppConfig::Rails.stub(:env).and_return("development")
    AppConfig::Rails.stub(:root) { Pathname.new(File.expand_path(File.dirname(__FILE__) + "/..")) }
    AppConfig.configure {}
  end

  after(:each) do
    AppConfig.send(:remove_const, :Rails)
  end

  it "Should default to the Rails environment" do
    AppConfig.configuration.environment.should == AppConfig::Rails.env
  end

  it "Should default to Rails.root/config/config.yml" do
    AppConfig.configuration.config_file.should == AppConfig::Rails.root.join("config/config.yml")
  end


end
