# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'refine/version'

Gem::Specification.new do |s|
  s.name = %q{refine-ruby}
  s.version = Refine::VERSION
  s.authors = ["Max Ogden", "Michael Bianco"]
  s.summary = %q{Client library for interacting with Google Refine instances}
  s.description = %q{Client library for interacting with Google Refine instances. Easily work with CSVs from the command line}
  s.email = ['max@maxogden.com', 'info@cliffsidedev.com']
  s.extra_rdoc_files = [
    "LICENSE",
    "README.textile"
  ]

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.homepage = "http://github.com/maxogden/refine-ruby"
  s.require_paths = ["lib"]

  s.test_files    = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.add_dependency('json', ">= 1.4.6")
  s.add_dependency('httpclient', ">= 2.1.6.1")
  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "minitest", "~> 5.11"
  s.add_development_dependency "pry"
  s.add_dependency 'addressable', '~> 2.5'

end
