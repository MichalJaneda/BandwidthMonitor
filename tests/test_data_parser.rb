require './lib/data_parser.rb'
require 'test/unit'

class TestDataParser < Test::Unit::TestCase

  def test_gets_address_and_initial_values
    parser = DataParser.new('wlp4s0')

    assert_true(parser.address.ipv4?)

    assert_operator(parser.received[:packets], :>, 0)
    assert_operator(parser.received[:bytes], :>, 0)

    assert_operator(parser.transferred[:packets], :>, 0)
    assert_operator(parser.transferred[:bytes], :>, 0)
  end

end