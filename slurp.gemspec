# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "slurp/version"

Gem::Specification.new do |s|
  s.name        = "slurp"
  s.version     = Slurp::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.summary     = "Super Login, Users, Roles, and Permissions"
  s.email       = "william@nine.is"
  s.homepage    = "http://nine.is/slurp"
  s.description = "A simple solution for handling login, users, roles, and permissions."
  s.authors     = ['William Barry']

  s.rubyforge_project = "slurp"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end
