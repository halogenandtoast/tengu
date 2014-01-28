module Tengu
  class CompositeMatcher
    def matches?(object)
      object
    end

    def > value
      Matcher.new { |object| object > value }
    end

    def >= value
      Matcher.new { |object| object >= value }
    end

    def < value
      Matcher.new { |object| object < value }
    end

    def <= value
      Matcher.new { |object| object <= value }
    end
  end
end
