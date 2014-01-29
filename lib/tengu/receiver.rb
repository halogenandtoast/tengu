require 'pry'

module Tengu
  class Receiver
    def initialize(message)
      @message = message
      @args = nil
      @return = nil
    end

    def with(*args)
      @args = args
      self
    end

    def and_return(return_value)
      @return = return_value
      self
    end

    def setup_allow(runner, object)
      unless object.respond_to?(:_tengu_received?)
        object.instance_eval do
          define_singleton_method(:_tengu_received) do
            @_tengu_received ||= Hash.new { |hash, key| hash[key] = [] }
          end

          define_singleton_method(:_tengu_received?) do |message, args = []|
            if args.length > 0
              _tengu_received[message] && _tengu_received[message].include?(args)
            else
              _tengu_received.keys.include?(message)
            end
          end
        end
      end

      message = @message
      return_value = @return
      if object.is_a? Tengu::Double
        object.instance_eval do
          define_singleton_method message, -> (*args) { _tengu_received[message] << args; return_value }
        end
      else
        original_method = object.method(@message.to_sym)
        runner.record_override(object, original_method)
        object.instance_eval do
          define_singleton_method message, -> (*args) { _tengu_received[message] << args; return_value }
        end
      end
    end
  end
end
