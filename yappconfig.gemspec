lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "app-config/version"

Gem::Specification.new do |s|
  s.name = "yappconfig"
  s.version = AppConfig::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["David Somers"]
  s.date = "2025-02-05"
  s.description = "yappconfig provides your application with a global configuration based on the environment. The configuration is loaded in from YAML. It has sensible defaults for Rails applications"
  s.email = "david@jalada.co.uk"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.homepage = "http://github.com/jalada/yappconfig"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "An application config, best for Rails apps"

  s.add_runtime_dependency "hashie", ">= 0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rdoc", "~> 6.11"
  s.add_development_dependency "bundler", ">= 0"
  s.add_development_dependency "simplecov", ">= 0"
  s.add_development_dependency "rails", "~> 7.0"
end

