# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phonetic/version'

Gem::Specification.new do |spec|
  spec.name          = 'phonetic'
  spec.version       = Phonetic::VERSION
  spec.authors       = ['n7v']
  spec.email         = ['novsem@gmail.com']
  spec.description   = %q{Ruby library for phonetic algorithms.}
  spec.summary       = %q{Ruby library for phonetic algorithms. It supports Soundex, Metaphone, Caverphone, NYSIIS and others}
  spec.homepage      = 'http://github.com/n7v/phonetic'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard'
end
