# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "underglow"
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Hu"]
  s.date = "2013-12-07"
  s.description = "A library that makes life easier."
  s.email = "axsuul@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".rspec",
    ".ruby-version",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "lib/underglow.rb",
    "lib/underglow/capistrano.rb",
    "lib/underglow/capistrano/deploy.rb",
    "lib/underglow/capistrano/deploy/db.rb",
    "lib/underglow/capistrano/deploy/rails.rb",
    "lib/underglow/capistrano/deploy/rake.rb",
    "lib/underglow/capistrano/deploy/unicorn.rb",
    "lib/underglow/capistrano/helpers.rb",
    "lib/underglow/extensions/array.rb",
    "lib/underglow/extensions/string.rb",
    "lib/underglow/extensions/symbol.rb",
    "lib/underglow/rails/environment.rb",
    "lib/underglow/tasks/db.rake",
    "lib/underglow/tasks/log.rake",
    "lib/underglow/tasks/system.rake",
    "lib/underglow/tasks/thin.rake",
    "lib/underglow/version.rb",
    "spec/extensions/array_spec.rb",
    "spec/extensions/string_spec.rb",
    "spec/extensions/symbol_spec.rb",
    "spec/spec_helper.rb",
    "underglow.gemspec"
  ]
  s.homepage = "http://github.com/axsuul/underglow"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Vroom yourself."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end

