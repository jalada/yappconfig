require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList["spec/**/*_spec.rb"]
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
  spec.rcov = true
end

task :default => :spec

require "rdoc/task"
require "app-config/version"
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "yappconfig #{AppConfig::VERSION}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end
