# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "underglow/version"

Gem::Specification.new do |s|
  s.name        = "underglow"
  s.version     = Underglow::VERSION
  s.authors     = ["James Hu"]
  s.email       = ["axsuul@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Makes life easier}
  s.description = %q{Don't you want the glow under you?}

  s.rubyforge_project = "underglow"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  # s.add_runtime_dependency "rest-client"
end
