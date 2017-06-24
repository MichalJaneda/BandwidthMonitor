require 'ipaddr'

class DataParser

  attr_reader :address, :transferred, :received

  def initialize(interface)
    @interface = interface
    @transferred, @received = {packets: 0, bytes: 0}, {packets: 0, bytes: 0}

    extract_address
    calculate_change
  end

  def main_loop
    loop do
      yield received, transferred
      calculate_change
      sleep 1
    end
  end

  private

  def extract_address
    # todo: extract with grep
    `ifconfig wlp4s0`.split("\n").each do |line|
      if line.lstrip.start_with?('inet ')
        @address = IPAddr.new line.scan(/(?<=addr:)((\d+\.?){4})/).first.first
      end
    end
  end

  def calculate_change
    # todo: extract with grep
    `ifconfig wlp4s0`.split("\n").each do |line|
      if line.lstrip.start_with?('RX packets:')
        @received[:packets] = line.scan(/\d+/).first.to_i
      elsif line.lstrip.start_with?('TX packets:')
        @transferred[:packets] = line.scan(/\d+/).first.to_i
      elsif line.lstrip.start_with?('RX bytes:')
        @received[:bytes] = line.scan(/\d+/).first.to_i
        @transferred[:bytes] = line.scan(/\d+/)[3].to_i
      end
    end
  end

end