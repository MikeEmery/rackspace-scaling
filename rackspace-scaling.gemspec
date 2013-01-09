# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rackspace-scaling/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mike Emery"]
  gem.email         = ["philodoxx@gmail.com"]
  gem.description   = %q{Gem that allows you to scale up or scale down the number of machines you ahve running in the rackspace cloud.}
  gem.summary       = %q{Gem that lets you scale the number of rackspace instances you have.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rackspace-scaling"
  gem.require_paths = ["lib"]
  gem.version       = Rackspace::Scaling::VERSION
  gem.add_runtime_dependency 'typhoeus', '~> 0.4.2'
end
