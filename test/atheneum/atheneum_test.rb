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
    assert_equal 'password'.reverse, store.send(:reversed_password)
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
    assert_equal 'other'.reverse, store.send(:reversed_other)
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
    assert_equal 'item'.upcase, store.send(:upper_cased_item)
  end

  def test_can_retrieve_a_item_upper_cased
    dummy_class = Struct.new(:upper_cased_item)
    dummy_class = dummy_class.include Atheneum.upper_case :item
    store = dummy_class.new 'item'.upcase
    assert_equal 'item', store.item
  end

  def test_can_include_multiple_strategies
    dummy_class = Struct.new(:upper_cased_item, :reversed_other)
    dummy_class = dummy_class.include Atheneum.upper_case :item
    dummy_class = dummy_class.include Atheneum.reverse :other
    store = dummy_class.new 'item'.upcase, 'password'.reverse
    assert_equal 'item', store.item
    assert_equal 'password', store.other
  end

  def test_method_missing_doesnt_affect_host_class
    dummy_class = Struct.new(:reversed_password)
    dummy_class = dummy_class.include Atheneum.reverse :password
    assert_raises NoMethodError do
      dummy_class.blah        
    end
  end

  def test_privatizes_storage_methods
    dummy_class = Struct.new(:reversed_password)
    dummy_class = dummy_class.include Atheneum.reverse :password
    store = dummy_class.new
    assert_raises NoMethodError do
      store.reversed_password
    end
    assert_raises NoMethodError do
      store.reversed_password = 3
    end
  end

  def test_privatizes_storage_methods_diff
    dummy_class = Struct.new(:upper_cased_item)
    dummy_class = dummy_class.include Atheneum.upper_case :item
    store = dummy_class.new
    assert_raises NoMethodError do
      store.upper_cased_item
    end
    assert_raises NoMethodError do
      store.upper_cased_item = 3
    end
  end
end