require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

RSpec.describe "AppConfig" do
  it "Should be accessible through APP_CONFIG too" do
    expect(APP_CONFIG).to eq AppConfig
  end

  it "Should set a config file" do
    AppConfig.configure do |config|
      config.config_file = config_file("test.yml")
    end
    expect(AppConfig.configuration.config_file).to eq config_file("test.yml")
  end

  it "Should set an environment" do
    AppConfig.configure do |config|
      config.environment = "production"
    end
    expect(AppConfig.configuration.environment).to eq "production"
  end

  it "Should raise an exception if config is accessed without setting a file" do
    expect { AppConfig.random_method }.to raise_error(AppConfig::Error, /Please set/)
  end

  it "Should default to autoreload" do
    expect(AppConfig.configuration.auto_reload).to eq true
  end

  describe "accessing the config" do
    describe "Single stage configuration" do
      before :each do
        AppConfig.configure do |config|
          config.config_file = config_file("single_stage.yml")
        end
      end

      it "Should work" do
        expect(AppConfig.simple_config).to eq "is simple"
      end
    end

    before :each do
      AppConfig.configure do |config|
        config.config_file = config_file("test.yml")
        config.environment = "development"
      end
    end

    it "Should support dot notation" do
      expect(AppConfig.test_key).to eq "value"
    end

    it "Should support square bracket notation" do
      expect(AppConfig["test_key"]).to eq "value"
    end

    describe "With auto-reload" do
      before :all do
        @original = File.read config_file("reloader.yml")
      end

      after :each do
        f = File.open(config_file("reloader.yml"), "w")
        f.write @original
        f.close
      end

      before :each do
        AppConfig.configure do |config|
          config.config_file = config_file("reloader.yml")
          config.auto_reload = true
        end
      end

      it "Should auto_reload on file change" do
        expect(AppConfig.test_key).to eq 1
        f = File.open(config_file("reloader.yml"), "w")
        f.write(@original.gsub(/1/, "2"))
        f.close
        expect(AppConfig.test_key).to eq 2
      end
    end

    describe "When the config contains ERB" do
      before :each do
        AppConfig.configure do |config|
          config.config_file = config_file("erb.yml")
        end
      end

      it "works" do
        expect(AppConfig.complex_erb).to eq "Has some complexity"
        expect(AppConfig.non_string_erb).to eq 42
      end
    end
  end
end
