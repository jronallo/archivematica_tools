# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "archivematica_tools/version"

Gem::Specification.new do |s|
  s.name        = "archivematica_tools"
  s.version     = ArchivematicaTools::VERSION
  s.authors     = ["Jason Ronallo"]
  s.email       = ["jason_ronallo@ncsu.edu"]
  s.homepage    = ""
  s.summary     = %q{Archivematica Tools}
  s.description = %q{Tools to make dealing with Archivematica packages simpler.}
  
  s.add_dependency('nokogiri')
  
  s.add_development_dependency('rspec')
  s.add_development_dependency('autotest')
  

  s.rubyforge_project = "archivematica_tools"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
