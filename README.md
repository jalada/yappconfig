# yappconfig

A clean way to use a YAML file for configuration.

## Configuring

In Rails, yappconfig should Just Work™. For everything else you can configure it
using a `configure` block: 

    AppConfig.configure do |config|
      config.config_file = "/path/to/config" # Default in Rails app is config/config.yml.
      config.environment = "production" # Multi-stage config files, default none.
      config.auto_reload = false # Defaults to true.
    end

## Sample configuration files

yappconfig supports single stage and multi-stage files. In Rails it will expect
a multi-stage file where the stages correspond with your Rails environment
variable. It will also expect the configuration file to be in
`config/config.yml` in the root of your application.

### Single stage example

    simple_config: "is simple"
    nested_config:
      is_nested: true

### Multi-stage example

Here, every stage inherits from defaults and then configurations can be
overriden.

    defaults: &defaults
    
      multistage_config: "is clever"
    
    development:
      <<: *defaults
    
    production:
      <<: *defaults
      
      multistage_config: "is very clever"

Watch out for this:

    defaults: &defaults
      
      server:
        host: localhost
        port: 6789
    
    production:
      <<: *defaults
      
      server:
        host: production-box
        # port is now unset!

That is, by overriding `server` all nested values have been 'deleted' because
it has been overridden with a new hash. In this example, you would have to
explicitly set `port` again in production. For this reason, it's probably best
to avoid too much nesting...


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

