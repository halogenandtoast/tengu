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
        puts "expected #{@object} to #{@matcher.description}"
      else
        puts "expected #{@object} not to #{@matcher.description}"
      end
    end
  end
end
