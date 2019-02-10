# frozen_string_literal: true

require 'httpcap/message'

module HTTPcap
  # Response
  class Response < Message
    attr_reader :http_status

    def initialize
      super(HTTP::Parser::TYPE_RESPONSE)
    end

    def on_message_complete
      @http_status = @parser.http_status
    end
  end
end
