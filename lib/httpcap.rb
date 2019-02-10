# frozen_string_literal: true

require 'reassemble_tcp'

require 'httpcap/version'
require 'httpcap/http_flow'
require 'httpcap/request'
require 'httpcap/response'

# HTTPcap - parse pcap, then return http request and response
module HTTPcap
  class Error < StandardError; end

  def self.send_recv_combined_tcp_data(filepath)
    Enumerator.new do |y|
      ReassembleTcp.tcp_connections(filepath).map do |stream|
        stream.tcpdata.each_slice(2) do |tcp_send, tcp_recv|
          y << [tcp_send, tcp_recv]
        end
      end
    end
  end

  # get HTTP request and response from pcap file
  # @param [String] filepath pcapfile path
  # @return [Array<HTTPcap::HTTPConnection>] http connections
  def self.http_flows(filepath)
    Enumerator.new do |y|
      send_recv_combined_tcp_data(filepath) do |tcp_send, tcp_recv|
        recv, send = [tcp_send, tcp_recv].sort_by { |tcp| tcp[1] }
        next unless send[1] == :send && recv[1] == :recv

        request = Request.new(send[2])
        response = Response.new(recv[2])

        y << HTTPFlow.new(request, response)
      end
    end
  end
end
