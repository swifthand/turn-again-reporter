require 'bundler/setup'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/reporters/turn_again_reporter'

Minitest::Reporters.use!(Minitest::Reporters::TurnAgainReporter.new)
