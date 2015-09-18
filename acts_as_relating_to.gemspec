$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_relating_to/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_relating_to"
  s.version     = ActsAsRelatingTo::VERSION
  s.authors     = ["Joseph"]
  s.email       = ["villajosephe@gmail.com"]
  s.homepage    = "http://www.bigbeelabs.com"
  s.summary     = "Summary of ActsAsRelatingTo."
  s.description = "Description of ActsAsRelatingTo."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2", ">=4.2.2"
  s.add_dependency "acts_as_taggable_on", '~> 0'


  s.add_development_dependency "pg", '~> 0'
  s.add_development_dependency "rspec-rails", '~> 0'
  s.add_development_dependency "factory_girl_rails", '~> 0'
    
end
