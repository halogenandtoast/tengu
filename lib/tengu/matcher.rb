module Tengu
  class Matcher
    attr_reader :description
    def initialize(description, &block)
      @description = description
      @block = block
    end

    def matches?(object)
      @block.call(object)
    end
  end
end
