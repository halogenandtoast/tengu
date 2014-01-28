module Tengu
  class Matcher
    def initialize(&block)
      @block = block
    end

    def matches?(object)
      @block.call(object)
    end
  end
end
