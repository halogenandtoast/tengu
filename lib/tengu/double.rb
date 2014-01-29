module Tengu
  class Double
    def initialize(identifier = nil, methods = {})
      @identifier = identifier
      methods.each do |message, value|
        define_singleton_method message, -> (*args) { _tengu_received[message] << args; value }
      end
    end

    def _tengu_received
      @_tengu_received ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def _tengu_received?(message, args = [])
      if args.length > 0
        _tengu_received[message] && _tengu_received[message].include?(args)
      else
        _tengu_received.keys.include?(message)
      end
    end
  end
end
