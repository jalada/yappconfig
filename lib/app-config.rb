require 'app-config/railtie' if defined?(Rails)
require 'erb'

# Public: Application Configuration singleton. Config is stored within as
# a class
module AppConfig

  # Private: Standard error.
  class Error < StandardError; end

  # Private: Actual configuration class. A new one of these is created whenever
  # AppConfig is configured.
  class Config
    require 'hashie'

    # Private: Initialize the class with a filename and environment (optional).
    # Takes a hash of options.
    #
    # filename - configuration filename. Must exist.
    # environment - optional, environment to pick in the configuration file.
    #
    # Returns the new config.
    def initialize(options)
      @options = options
      yaml = YAML.load(ERB.new(IO.read @options.config_file).result, aliases: true)
      yaml = yaml[@options.environment] if @options.environment
      @config = Hashie::Mash.new yaml
      @last_mtime = File.mtime @options.config_file
      @config
    end

    # Private: Override method_missing to access the config object. If the file
    # has been modified and auto_reload is set to true, re-run initialize.
    #
    # Returns the result of applying the method to the config object.
    def method_missing(method, *args, &block)
      if @options.auto_reload and @last_mtime != File.mtime(@options.config_file)
        initialize @options
      end
      @config.__send__(method, *args, &block)
    end

  end

  # Create a configuration attribute
  class << self
    attr_accessor :configuration
  end

  # Public: Configure AppConfig. Note that repeated calls to configure will
  # reset all configuration and clear the existing config class. Therefore you
  # need to configure AppConfig all in one go, or alternatively access
  # configuration parameters directly e.g. AppConfig.configuration.config_file
  #
  # Yields to the provided block, then sets defaults on top.
  def self.configure(&block)
    self.configuration = Configuration.new
    @klass = nil
    yield(configuration)
    self.configuration.defaults
  end

  # Private: Holds the configuration.
  class Configuration
    attr_accessor :environment
    attr_accessor :config_file
    attr_accessor :auto_reload

    # Private: Set default configuration values that haven't been set by
    # the user
    def defaults
      @auto_reload ||= @environment == "production" ? false : true
    end

    def config_file=(filename)
      raise Error, "File does not exist or is not a file: #{filename}" unless File.file? filename
      @config_file = filename
    end
  end

  def self.method_missing(method, *args, &block)
    if @klass || self.configuration.config_file
      @klass ||= Config.new(self.configuration)
      @klass.__send__(method, *args, &block)
    else
      raise Error, "Please set a config_file with AppConfig.configure first"
    end
  end

  # Default configuration
  configure {}

end

# Alias for old applications
APP_CONFIG = AppConfig
# Alias for people who like to yap.
YappConfig = YAPP_CONFIG = AppConfig
