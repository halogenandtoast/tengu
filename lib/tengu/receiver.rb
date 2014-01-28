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
      message = @message
      return_value = @return
      if object.is_a? Tengu::Double
        object.instance_eval do
          define_singleton_method message, -> (*args) { return_value }
        end
      else
        original_method = object.method(@message.to_sym)
        runner.record_override(object, original_method)
        object.instance_eval do
          define_singleton_method message, -> (*args) { return_value }
        end
      end
    end
  end
end
