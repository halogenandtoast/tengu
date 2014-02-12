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
      object.define_singleton_method message, -> (*args) { _tengu_received[message] << args; return_value }
    end

    def setup_tengu_for(object)
      unless object.respond_to?(:_tengu_received?)
        object.singleton_class.send(:include, Tengu::Internals)
      end
    end
  end
end
