module Tengu
  class Allow
    def initialize(runner, object)
      @runner = runner
      @object = object
    end

    def to(receiver)
      receiver.setup_allow(@runner, @object)
    end
  end
end
