require 'bcrypt'
require_relative '../test_config'

BCrypt::Engine.cost = 1

class BcryptTest < MiniTest::Test
  def strategy(options={})
    @strategy = Atheneum::Strategy::Crypt.new options
  end

  def teardown
    @strategy = nil
  end

  def test_hashes_saved_string
    BCrypt::Password.stub :create, 'hashed' do
      assert_equal 'hashed', strategy.pack('string')
    end
  end

  def test_returns_saved_item
    assert_equal strategy.unpack(BCrypt::Password.create('password').to_s), 'password'
  end

  def test_stored_attribute_prefixed_with_crypted
    assert_equal 'crypted_password', strategy.store_for(:password)
  end
end