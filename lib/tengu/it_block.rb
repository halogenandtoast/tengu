require "tengu/matchers"
require "tengu/double"
require "tengu/allow"
require "tengu/receiver"

module Tengu
  class ItBlock
    include Matchers
    attr_reader :description, :expectations

    def initialize(describe_block, description, block)
      @describe_block = describe_block
      @description = description
      @block = block
      @success = true
      @pending = false
      @expectations = []
      @error = nil
    end

    def run(listeners = [])
      @listeners = listeners
      begin
        instance_eval(&@block)
      rescue Exception => e
        @error = e
        @success = false
      end
      notify(@listeners)
    end

    def errored?
      @error
    end

    def success?
      unless pending? || errored?
        @expectations.all? { |expectation| expectation.success? }
      end
    end

    def pending?
      @pending
    end

    private

    def allow(object)
      Allow.new(@listeners, object)
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
        listener.notify(:finished_case, self)
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

    def method_missing(method, *args, &block)
      @describe_block.send(method, *args, &block)
    end
  end
end
