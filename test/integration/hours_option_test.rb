require 'test_helper'

Minitest::Reporters.use!(Minitest::Reporters::TurnAgainReporter.new(
  hours: true
))

class HoursOptionTest < Minitest::Test

  def test_the_truth_with_hours_in_timestamp
    assert(true)
  end

end
