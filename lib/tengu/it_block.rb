require "tengu/matchers"

module Tengu
  class ItBlock
    include Matchers

    def initialize(description, block)
      @description = description
      @block = block
      @success = true
      @pending = false
      @expectations = []
    end

    def success?
      unless pending?
        @expectations.all? { |expectation| expectation.success? }
      end
    end

    def run(listeners = [])
      instance_eval(&@block)
      notify(listeners)
    end

    def notify(listeners)
      listeners.each do |listener|
        listener.notify(success_state, self)
      end
    end

    def success_state
      if pending?
        :pending
      elsif success?
        :success
      else
        :failure
      end
    end

    def pending?
      @pending
    end

    def pending
      @success = false
      @pending = true
    end

    def expect(object)
      expectation = Expectation.new(object)
      @expectations << expectation
      expectation
    end
  end
end
