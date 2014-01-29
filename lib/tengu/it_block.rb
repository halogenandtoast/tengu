require "tengu/matchers"
require "tengu/double"
require "tengu/allow"
require "tengu/receiver"

module Tengu
  class ItBlock
    include Matchers
    attr_reader :description, :expectations

    def initialize(description, block)
      @description = description
      @block = block
      @success = true
      @pending = false
      @expectations = []
    end

    def run(runner, listeners = [])
      @runner = runner
      instance_eval(&@block)
      @runner.reset_overrides
      notify(listeners)
    end

    def success?
      unless pending?
        @expectations.all? { |expectation| expectation.success? }
      end
    end

    def pending?
      @pending
    end

    private

    def allow(object)
      Allow.new(@runner, object)
    end

    def receive(message)
      Receiver.new(message)
    end

    def double(identifier = nil, args = {})
      Double.new(identifier, args)
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
