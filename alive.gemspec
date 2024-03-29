# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alive/version"

Gem::Specification.new do |s|
  s.name        = "alive"
  s.version     = Alive::VERSION
  s.authors     = ["Alvaro Bautista"]
  s.email       = ["alvarobp@gmail.com"]
  s.homepage    = ""
  s.summary     = "Conway's Game of Life"
  s.description = "Conway's Game of Life"

  s.rubyforge_project = "alive"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
