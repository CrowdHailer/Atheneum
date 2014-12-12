require_relative '../test_config'

class AtheneumTest < MiniTest::Test
  def test_raises_error_for_undefined_strategy
    err = assert_raises Atheneum::StrategyUndefined do
      Atheneum.no_strategy
    end
    assert_match(/NoStrategy/, err.message)
  end

  def test_can_store_a_password_reversed
    dummy_class = Struct.new(:reversed_password)
    dummy_class = dummy_class.include Atheneum.reverse :password
    store = dummy_class.new
    store.password = 'password'
    assert_equal 'password'.reverse, store.reversed_password
  end

  def test_can_retrieve_a_password_reversed
    dummy_class = Struct.new(:reversed_password)
    dummy_class = dummy_class.include Atheneum.reverse :password
    store = dummy_class.new 'password'.reverse
    assert_equal 'password', store.password
  end

  def test_can_store_a_other_reversed
    dummy_class = Struct.new(:reversed_other)
    dummy_class = dummy_class.include Atheneum.reverse :other
    store = dummy_class.new
    store.other = 'other'
    assert_equal 'other'.reverse, store.reversed_other
  end

  def test_can_retrieve_a_other_reversed
    dummy_class = Struct.new(:reversed_other)
    dummy_class = dummy_class.include Atheneum.reverse :other
    store = dummy_class.new 'other'.reverse
    assert_equal 'other', store.other
  end

  def test_can_store_a_item_upper_cased
    dummy_class = Struct.new(:upper_cased_item)
    dummy_class = dummy_class.include Atheneum.upper_case :item
    store = dummy_class.new
    store.item = 'item'
    assert_equal 'item'.upcase, store.upper_cased_item
  end

  def test_can_retrieve_a_item_upper_cased
    dummy_class = Struct.new(:upper_cased_item)
    dummy_class = dummy_class.include Atheneum.upper_case :item
    store = dummy_class.new 'item'.upcase
    assert_equal 'item', store.item
  end
end