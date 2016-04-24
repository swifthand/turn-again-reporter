require 'test_helper'

class ErrorFormatTest < Minitest::Test

  def test_failure_in_assert
    assert(true * 5)
  end

  def test_failure_before_assert
    result = Object.new.nonexistentmethod
    refute(result)
  end

end
