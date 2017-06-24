require './lib/bandwidth_monitor.rb'
require 'test/unit'

class TestBandWidthMonitor < Test::Unit::TestCase

  def test_returns_interfaces
    assert_equal(%w{enp3s0 lo wlp4s0}, BandwidthMonitor.interfaces_available)
  end

  def test_connect_to_valid_interface
    monitor = BandwidthMonitor.new('wlp4s0')

    assert_true(monitor.valid?)
  end

  def test_connect_to_invalid_interface
    monitor = BandwidthMonitor.new('invalid')

    assert_false(monitor.valid?)
  end

end