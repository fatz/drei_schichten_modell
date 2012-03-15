# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "drei_schichten_modell/version"

Gem::Specification.new do |s|
  s.name                      = "drei_schichten_modell"
  s.version                   = '0.0.5'
  s.authors                   = ["Felix Faerber"]
  s.email                     = ["mail@ffaerber.com"]
  s.homepage                  = "https://github.com/ffaerber/drei_schichten_modell"
  s.summary                   = %q{drei schichten model altersforsorge rechner infos dazu hier:http://www.3-schichten-modell.de oder einfach googlen}
  s.description               = %q{dieses rubygem berechnet den perfekten altersvorsorge mix aus allen drei schichten. und gibt angaben ueber die zulagenhoehe}
  s.rubyforge_project         = "drei_schichten_modell"
  s.files                     = `git ls-files`.split("\n")
  s.test_files                = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables               = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths             = ["lib"]
  s.test_files                = Dir.glob('spec/**/*')
  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'abgabenrechner',  '~> 0.3.3' 
end