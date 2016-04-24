require 'test_helper'

Minitest::Reporters.use!(Minitest::Reporters::TurnAgainReporter.new(
  indent: 12
))

class IndentOptionTest < Minitest::Test

  def test_waaay_over_there
    assert(true)
  end


  def test_this_is_actually_pretty_gross
    assert(true)
  end


  def test_an_obscene_waste_of_space
    assert(true)
  end

end
