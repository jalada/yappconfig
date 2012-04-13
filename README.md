# AppConfig

A clean way to use a YAML file for configuration.

## Configuring

    AppConfig.configure do |config|
      config.config_file = "/path/to/config" # Default in Rails app is config/config.yml.
      config.environment = "production" # Multi-stage config files, default none.
      config.auto_reload = false # Defaults to true.
    end


## Contributing to app-config
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 David Somers <jalada@gmail.com>. See LICENSE.txt for further
details.

