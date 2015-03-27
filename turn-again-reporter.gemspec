# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name           = "turn_again_reporter"
  spec.version        = Minitest::Reporters::TurnAgainReporter::VERSION
  spec.platform       = Gem::Platform::RUBY
  spec.authors        = ["Paul Kwiatkowski"]
  spec.email          = ["paul@groupraise.com"]
  spec.summary        = %q{A reporter for the minitest-reporters gem that more accurately mimics the behavior of the turn gem.}
  spec.description    = %q{A reporter for the minitest-reporters gem that more accurately mimics the behavior of the turn gem.}
  spec.homepage       = "https://github.com/swifthand/turn-again-reporter"
  spec.license        = "MIT"

  spec.files          = `git ls-files -z`.split("\x0")
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "minitest-reporters", "~> 1.0.11"
end
