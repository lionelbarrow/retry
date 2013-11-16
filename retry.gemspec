require File.expand_path('../lib/retry/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "retry"
  spec.version       = Retry::VERSION
  spec.authors       = ["lionelbarrow"]
  spec.email         = ["code@getbraintree.com"]
  spec.description   = "Provides generic functions for retry strategies."
  spec.summary       = "Provides generic functions for retry strategies."
  spec.homepage      = "https://www.github.com/lionelbarrow/retry"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "rake"
end
