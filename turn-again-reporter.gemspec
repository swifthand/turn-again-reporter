# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/reporters/turn_again_reporter'

Gem::Specification.new do |spec|
  spec.name           = "turn-again-reporter"
  spec.version        = Minitest::Reporters::TurnAgainReporter::VERSION
  spec.platform       = Gem::Platform::RUBY
  spec.authors        = ["Paul Kwiatkowski"]
  spec.email          = ["paul@groupraise.com"]
  spec.summary        = %q{A reporter for the minitest-reporters gem that more accurately mimics the behavior of the turn gem.}
  spec.description    = %q{A reporter for the minitest-reporters gem that more accurately mimics the behavior of the turn gem. Specifically, the test's status banner is now on the left, removing the need to limit the length of test names for the sake of aesthetics and readability (as in the case of Minitest::Reporters::SpecReporter included with the minitest-reporters gem).}
  spec.homepage       = "https://github.com/swifthand/turn-again-reporter"
  spec.license        = "MIT"

  spec.files          = `git ls-files -z`.split("\x0")
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "minitest-reporters", "~> 1.0", ">= 1.0.8"
end
