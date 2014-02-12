module Tengu
  class StubInitializer
    def initialize(object, message)
      @object = object
      @message = message
    end

    def stub(return_value)
    end
  end
end
