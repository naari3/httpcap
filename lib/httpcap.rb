# frozen_string_literal: true

require 'reassemble_tcp'

require 'httpcap/version'
require 'httpcap/http_flow'

# HTTPcap - parse pcap, then return http request and response
module HTTPcap
  class Error < StandardError; end

  # get HTTP connections from pcap file
  # @param [String] filepath pcapfile path
  # @return [Array<HTTPcap::HTTPConnection>] http connections
  def self.http_connections(filepath)
    Enumerator.new do |y|
      ReassembleTcp.tcp_connections(filepath).map do |stream|
        stream.tcpdata.each_slice(2) do |tcp_send, tcp_recv|
          next unless tcp_send[1] == :send
          next unless tcp_recv[1] == :recv

          y << HTTPFlow.new(tcp_send[2], tcp_recv[2])
        end
      end
    end
  end
end
