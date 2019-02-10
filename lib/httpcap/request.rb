# frozen_string_literal: true

require 'httpcap/message'

module HTTPcap
  # Request
  class Request < Message
    attr_reader :http_method

    def initialize(data)
      @http_method = ''
      @relative_url = ''

      super(HTTP::Parser::TYPE_REQUEST, data)
    end

    def url
      @headers.fetch('Host', '') + @relative_url
    end

    def on_url(url)
      @relative_url = url
    end

    def on_message_complete
      @http_method = @parser.http_method
    end
  end
end
