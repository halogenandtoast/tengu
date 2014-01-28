module Tengu
  class Expectation
    def initialize(object)
      @object = object
      @success = false
    end

    def success?
      @success
    end

    def to(matcher)
      @success = matcher.matches?(@object)
    end
  end
end
