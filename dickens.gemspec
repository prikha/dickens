# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dickens/version"

Gem::Specification.new do |s|
  s.name        = "dickens"
  s.version     = Dickens::VERSION
  s.authors     = ["Sergey Prikhodko"]
  s.email       = ["sergey@zengile.com"]
  s.homepage    = "http://github.com/prikha/dickens"
  s.summary     = "Dickens if for offline dictionaries lookup. It is built upon SDCV (StarDict console version)"
  s.description = "For now you can gather all your dictionaries together and search through them getting pretty rails-style records back"

  s.rubyforge_project = "dickens"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"

end
