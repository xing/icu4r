# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "icu4r"
  s.version     = "0.1.5.2011.04.06"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Stefan Kaes"]
  s.email       = ["stefan.kaes@xing.com"]
  s.homepage    = ""
  s.summary     = %q{ICU bindings for ruby 1.8.7}
  s.description = %q{ICU bindings for ruby 1.8.7}

  s.extensions    = "ext/extconf.rb"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
