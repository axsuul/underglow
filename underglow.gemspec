# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "underglow/version"

Gem::Specification.new do |gem|
  gem.name        = "underglow"
  gem.version     = Underglow::VERSION
  gem.authors     = ["James Hu"]
  gem.email       = ["axsuul@gmail.com"]
  gem.homepage    = "http://www.github.com/axsuul/underglow"
  gem.summary     = gem.description = %q{Makes life worth living}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
end
