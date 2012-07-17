require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "AppConfig" do


  it "Should be accessible through APP_CONFIG too" do
    APP_CONFIG.should == AppConfig
  end

  it "Should set a config file" do
    AppConfig.configure do |config|
      config.config_file = config_file("test.yml")
    end
    AppConfig.configuration.config_file.should == config_file("test.yml")
  end

  it "Should set an environment" do
    AppConfig.configure do |config|
      config.environment = "production"
    end
    AppConfig.configuration.environment.should == "production"
  end

  it "Should raise an exception if config is accessed without setting a file" do
    expect { AppConfig.random_method }.to raise_error(AppConfig::Error, /Please set/)
  end

  it "Should default to autoreload" do
    AppConfig.configuration.auto_reload.should == true
  end

  describe "accessing the config" do
    describe "Single stage configuration" do
      before :each do
        AppConfig.configure do |config|
          config.config_file = config_file("single_stage.yml")
        end
      end

      it "Should work" do
        AppConfig.simple_config.should == "is simple"
      end
    end

    before :each do
      AppConfig.configure do |config|
        config.config_file = config_file("test.yml")
        config.environment = "development"
      end
    end

    it "Should support dot notation" do
      AppConfig.test_key.should == "value"
    end

    it "Should support square bracket notation" do
      AppConfig[:test_key].should == "value"
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
        AppConfig.test_key.should == 1
        f = File.open(config_file("reloader.yml"), "w")
        f.write(@original.gsub(/1/, "2"))
        f.close
        AppConfig.test_key.should == 2
      end
    end
  end
end
