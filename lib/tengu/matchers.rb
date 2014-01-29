require "tengu/receive_matcher"

module Tengu
  module Matchers
    def be_true
      eq(true)
    end

    def be_false
      eq(false)
    end

    def be_nil
      eq(nil)
    end

    def have_received(message)
      ReceiveMatcher.new(message, "have received #{message.inspect}") { |object| object._tengu_received?(message) }
    end

    def include(value)
      Matcher.new("include #{value.inspect}") { |object| object.include?(value) }
    end

    def eq(value)
      Matcher.new("be eq to #{value.inspect}") { |object| object == value }
    end

    def eql(value)
      Matcher.new("be eql to #{value.inspect}")  { |object| object.eql?(value) }
    end

    def equal(value)
      Matcher.new("be equal to #{value.inspect}") { |object| object.equal?(value) }
    end

    def be(value = nil)
      if value
        equal(value)
      else
        CompositeMatcher.new
      end
    end

    def be_instance_of(value)
      Matcher.new("be instance of #{value.inspect}") { |object| object.instance_of?(value) }
    end

    def be_kind_of(value)
      Matcher.new("be kind of #{value.inspect}") { |object| object.kind_of?(value) }
    end

    def match(value)
      Matcher.new("match #{value.inspect}") { |object| object =~ value }
    end
  end
end
