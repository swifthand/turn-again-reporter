require 'test_helper'

class SkipFormatTest < Minitest::Test

  def test_skip_one
    skip
  end

  def test_skip_two
    assert(true)
    skip
  end

end
