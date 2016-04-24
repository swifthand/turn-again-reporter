require 'test_helper'

Minitest::Reporters.use!(Minitest::Reporters::TurnAgainReporter.new(
  pass_color:   :blue,
  fail_color:   :magenta,
  error_color:  :cyan,
  skip_color:   :black
))

class ColorOptionsTest < Minitest::Test

  def test_the_truth
    assert(true)
  end

  def test_failing_the_truth
    refute(true)
  end

  def test_triggering_an_error
    Object.new.triggernomethoderror
  end

  def test_skip_color
    skip
  end

end
