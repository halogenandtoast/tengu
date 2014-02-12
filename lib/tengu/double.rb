module Tengu
  class Double
    include Tengu::Internals

    def initialize(identifier = nil, methods = {})
      @identifier = identifier
      methods.each do |message, value|
        define_singleton_method message, -> (*args) { _tengu_received[message] << args; value }
      end
    end

    def _tengu_stub_method(message, return_value)
      define_singleton_method message, -> (*args) { _tengu_received[message] << args; return_value }
    end
  end
end
