# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoo_stream/version'

Gem::Specification.new do |spec|
  spec.name          = "zoo_stream"
  spec.version       = ZooStream::VERSION
  spec.authors       = ["Marten Veldthuis"]
  spec.email         = ["marten@zooniverse.org"]

  spec.summary       = %q{Simplified and customized Kinesis publisher}
  spec.description   = %q{A wrapper around AWS Kinesis client to make sure all our applications publish messages with a consistent format.}
  spec.homepage      = "https://github.com/zooniverse/zoo_stream"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'aws-sdk'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
