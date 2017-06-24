require_relative 'data_parser'

class BandwidthMonitor

  def initialize(interface)
    @interface = interface
  end

  def self.interfaces_available
    interfaces = `ip link show | grep -oP "(?<=\\d: )[^ :]+:" --color=never`
    interfaces.tr(':', '').split.sort
  end

  def valid?
    self.class.interfaces_available.include? @interface
  end

  def run
    DataParser.new(@interface).main_loop do |received, transferred|
      # todo: format, change, Mb
      puts Time.now
      puts "Received:\tpackets:#{received[:packets]}\tbytes:#{received[:bytes]}"
      puts "Transferred:\tpackets:#{transferred[:packets]}\t\tbytes:#{transferred[:bytes]}"
    end
  end

end