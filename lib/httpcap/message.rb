# frozen_string_literal: true

require 'http-parser'

require 'httpcap/headers'

module HTTPcap
  # Message is a abstract class for Request and Response
  class Message
    attr_reader :body, :headers

    # @param [Integer] type request or response
    def initialize(type)
      @parser = HTTP::Parser.new(type)
      @headers = Headers.new
      @body = ''

      %i[on_message_complete on_url on_header_field on_header_value on_headers_complete on_body].each do |name|
        @parser.send(name, &method(name))
      end
    end

    def receive_data(data)
      @parser << data
    end

    def on_message_complete; end

    def on_url; end

    def on_header_field(value)
      @headers.stream(Headers::TYPE_FIELD, value)
    end

    def on_header_value(value)
      @headers.stream(Headers::TYPE_VALUE, value)
    end

    def on_headers_complete
      @headers.stream_complete
    end

    def on_body(data)
      @body += data
    end
  end
end
