# frozen_string_literal: true

require 'reassemble_tcp'

require 'httpcap/version'
require 'httpcap/http_flow'
require 'httpcap/request'
require 'httpcap/response'

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
          next unless tcp_send[1] == :send && tcp_recv[1] == :recv

          request = Request.new(tcp_send[2])
          response = Response.new(tcp_recv[2])

          y << HTTPFlow.new(request, response)
        end
      end
    end
  end
end
