require "tengu/matchers"
require "tengu/double"
require "tengu/allow"
require "tengu/receiver"

module Tengu
  class ItBlock
    include Matchers
    attr_reader :description, :expectations, :error, :filename

    def initialize(describe_block, description, block, filename = "", options = {})
      @describe_block = describe_block
      @description = description
      @block = block
      @success = true
      @pending = false
      @expectations = []
      @error = nil
      @filename = filename
      @listeners = options.fetch(:listeners) { [] }
    end

    def run
      begin
        instance_eval(&@block)
      rescue Exception => e
        @error = e
        @success = false
      end
      notify_listeners
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
    attr_reader :listeners

    def allow(object)
      Allow.new(listeners, object)
    end

    def receive(message)
      Receiver.new(message)
    end

    def double(identifier = nil, args = {})
      Double.new(identifier, args)
    end

    def notify_listeners
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
