# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tengu/version'

Gem::Specification.new do |spec|
  spec.name          = "tengu"
  spec.version       = Tengu::VERSION
  spec.authors       = ["halogenandtoast"]
  spec.email         = ["halogenandtoast@gmail.com"]
  spec.description   = %q{A truly object oriented testing library}
  spec.summary       = %q{A truly object oriented testing library}
  spec.homepage      = "http://github.com/halogenandtoast/tengu"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
