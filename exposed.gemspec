$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "exposed/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "exposed"
  s.version     = Exposed::VERSION
  s.authors     = ["Rodoljub Petrovic"]
  s.email       = ["me@rodpetrovic.com"]
  s.homepage    = "https://github.com/rodp/exposed"
  s.summary     = "A Rails engine that exposes ActiveRecord models as JSON API with minimum hassle"
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.6"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
