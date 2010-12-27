# -*- encoding: utf-8 -*-
require File.expand_path("../lib/booyah/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "booyah"
  s.version     = Booyah::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mathias Dahlström"]
  s.email       = ["mathias.dahlstrom@gmail.com"]
  s.homepage    = "http://github.com/mdahlstrom/booyah"
  s.summary     = "gem for audioboo api"
  s.description = "gem to search for audioboo clips based on geolocation"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "booyah"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_dependency('httparty', '~> 0.6.1')
  
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end