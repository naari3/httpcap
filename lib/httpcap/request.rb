# frozen_string_literal: true

require 'httpcap/message'

module HTTPcap
  # Request
  class Request < Message
    attr_reader :http_method

    def initialize
      @http_method = ''

      super(HTTP::Parser::TYPE_REQUEST)
    end

    def on_message_complete
      @http_method = @parser.http_method
    end
  end
end
