module Tengu
  module Matchers
    def be_true
      eq(true)
    end

    def be_false
      eq(false)
    end

    def be_false
      eq(nil)
    end

    def eq(value)
      Matcher.new { |object| object == value }
    end

    def eql(value)
      Matcher.new { |object| object.eql?(value) }
    end

    def equal(value)
      Matcher.new { |object| object.equal?(value) }
    end

    def be(value = nil)
      if value
        equal(value)
      else
        CompositeMatcher.new
      end
    end

    def be_instance_of(value)
      Matcher.new { |object| object.instance_of?(value) }
    end

    def be_kind_of(value)
      Matcher.new { |object| object.kind_of?(value) }
    end

    def match(value)
      Matcher.new { |object| object =~ value }
    end
  end
end
