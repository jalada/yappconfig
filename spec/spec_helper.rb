$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'app-config'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
  config.before(:each) do
    # Simulate it being loaded for the first time; empty config.
    # TODO: Can you force reload?
    AppConfig.configure {}
  end
end

def config_file(name)
  File.join(File.dirname(__FILE__), "config", name)
end
