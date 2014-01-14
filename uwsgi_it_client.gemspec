# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uwsgi_it_client/version'

Gem::Specification.new do |spec|
  spec.name          = "uwsgi_it_client"
  spec.version       = UwsgiItClient::VERSION
  spec.authors       = ["andrea longhi", "nicola racco"]
  spec.email         = ["andrea@mikamai.com", "nicola@mikamai.com"]
  spec.description   = %q{ruby client for uwsgi.it api}
  spec.summary       = %q{ruby client for uwsgi.it api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
