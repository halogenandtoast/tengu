module Tengu
  class Receiver
    def initialize(message)
      @message = message
      @args = nil
      @return_value = nil
    end

    def with(*args)
      @args = args
      self
    end

    def and_return(return_value)
      @return_value = return_value
      self
    end

    def setup_allow(listeners, object)
      setup_tengu_for(object)
      setup_mocking(listeners, object)
    end

    private

    attr_reader :message, :return_value

    def setup_mocking(listeners, object)
      if object.respond_to? :_tengu_stub_method
        object._tengu_stub_method(message, return_value)
      else
        setup_normal_object(listeners, object, message, return_value)
      end
    end

    def setup_normal_object(listeners, object, message, return_value)
      original_method = object.method(message.to_sym)
      listeners.each { |listener| listener.notify(:override, [object, original_method]) }
      object.instance_eval do
        define_singleton_method message, -> (*args) { _tengu_received[message] << args; return_value }
      end
    end

    def setup_tengu_for(object)
      unless object.respond_to?(:_tengu_received?)
        setup_tengu_received(object)
        setup_tengu_received?(object)
      end
    end

    def setup_tengu_received(object)
      object.instance_eval do
        define_singleton_method(:_tengu_received) do
          @_tengu_received ||= Hash.new { |hash, key| hash[key] = [] }
        end
      end
    end

    def setup_tengu_received?(object)
      object.instance_eval do
        define_singleton_method(:_tengu_received?) do |message, args = []|
          if args.length > 0
            _tengu_received[message] && _tengu_received[message].include?(args)
          else
            _tengu_received.keys.include?(message)
          end
        end
      end
    end
  end
end
