require "tengu/matcher"

module Tengu
  class ReceiveMatcher < Matcher
    def initialize(method_message, message, &block)
      @method_message = method_message
      @message = message
      @with = nil
      super(message, &block)
    end

    def with(*args)
      method_message = @method_message
      @block = -> (object) { object._tengu_received?(method_message, args) }
      self
    end
  end
end
