require_relative '../test_config'

class AtheneumTest < MiniTest::Test
  def test_raises_error_for_undefined_strategy
    err = assert_raises Atheneum::StrategyUndefined do
      Atheneum.no_strategy
    end
    assert_match(/no_strategy/, err.message)
  end

  def test_can_store_a_password_reversed
    dummy_class = Struct.new(:reversed_password)
    dummy_class = dummy_class.include Atheneum.reverse :password
    store = dummy_class.new
    store.password = 'password'
    assert_equal 'password'.reverse, store.reversed_password
  end
end