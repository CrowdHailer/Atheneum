require_relative '../test_config'

class AtheneumTest < MiniTest::Test
  def test_raises_error_for_undefined_strategy
    err = assert_raises Atheneum::StrategyUndefined do
      Atheneum.no_strategy
    end
    assert_match(/no_strategy/, err.message)
  end
end