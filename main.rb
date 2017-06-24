#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require_relative 'lib/bandwidth_monitor'

monitor = BandwidthMonitor.new('wlp4s0')
monitor.run
