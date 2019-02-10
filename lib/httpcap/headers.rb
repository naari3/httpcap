# frozen_string_literal: true

require 'forwardable'

module HTTPcap
  # http headers for http-parser
  class Headers
    extend Forwardable

    TYPE_FIELD = :f
    TYPE_VALUE = :v

    %i[fetch [] each map].each do |method|
      def_delegator :@content, method, method
    end

    def initialize
      @content = {}
      @bucket = []
      @state = nil
    end

    def stream(type, value)
      if @state == type
        @bucket[-1] += value
      else
        @bucket << value
      end
      @state = type
    end

    def stream_complete
      @content.merge!(@bucket.each_slice(2).to_a.select { |a| a.size == 2 }.to_h)
      @bucket.clear
    end
  end
end
