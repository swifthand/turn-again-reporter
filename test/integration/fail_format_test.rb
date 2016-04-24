require 'test_helper'

class FailFormatTest < Minitest::Test

  def test_failing_the_truth
    refute(true)
  end

  def test_failure_of_denial
    assert(false)
  end

end
