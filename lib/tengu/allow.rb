module Tengu
  class Allow
    def initialize(listeners, object)
      @listeners = listeners
      @object = object
    end

    def to(receiver)
      receiver.setup_allow(@listeners, @object)
    end
  end
end
