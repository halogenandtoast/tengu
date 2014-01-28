module Tengu
  class CompositeMatcher
    def matches?(object)
      object
    end

    def > value
      Matcher.new("be greater than #{value.inspect}") { |object| object > value }
    end

    def >= value
      Matcher.new("be greater than or equal to #{value.inspect}") { |object| object >= value }
    end

    def < value
      Matcher.new("be less than #{value.inspect}") { |object| object < value }
    end

    def <= value
      Matcher.new("be less than or equal to #{value.inspect}") { |object| object <= value }
    end
  end
end
