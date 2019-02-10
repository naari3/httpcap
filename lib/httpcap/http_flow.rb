# frozen_string_literal: true

module HTTPcap
  # Combining request and response
  class HTTPFlow
    attr_reader :request, :response

    # @param [String] request
    # @param [String] response
    def initialize(request, response)
      @request = request
      @response = response
    end
  end
end
