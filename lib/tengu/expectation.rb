module Tengu
  class Expectation
    def initialize(object)
      @object = object
      @success = false
      @positive = true
      @matcher = nil
    end

    def success?
      @success
    end

    def to(matcher)
      @matcher = matcher
      @success = @matcher.matches?(@object)
    end

    def not_to(matcher)
      @positive = false
      @matcher = matcher
      @success = !@matcher.matches?(@object)
    end

    def message
      if @positive
        "expected #{@object.inspect} to #{@matcher.description}"
      else
        "expected #{@object.inspect} not to #{@matcher.description}"
      end
    end
  end
end
