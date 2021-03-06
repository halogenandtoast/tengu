module Tengu
  class DescribeBlock
    def initialize(description, block, filename = "", options = {})
      @description = description
      @block = block
      @test_cases = []
      @before_each_hooks = []
      @after_each_hooks = []
      @filename = filename
      @listeners = options.fetch(:listeners) { [] }
      load_test_cases
    end

    def run
      test_cases.each do |test_case|
        before_each_hooks.each(&:call)
        test_case.run
        after_each_hooks.each(&:call)
      end
    end

    def success_count
      test_cases.count { |test_case| test_case.success? }
    end

    def test_count
      test_cases.count { |test_case| !test_case.pending? }
    end

    def pending_count
      test_cases.count { |test_case| test_case.pending? }
    end

    def double(identifier = nil, args = {})
      Double.new(identifier, args)
    end

    private
    attr_reader :test_cases, :listeners
    attr_reader :before_each_hooks, :after_each_hooks

    def include(included_module)
      singleton_class.send(:include, included_module)
    end

    def before(type, &block)
      if type == :each
        @before_each_hooks << block
      end
    end

    def after(type, &block)
      if type == :each
        @after_each_hooks << block
      end
    end


    def load_test_cases
      instance_eval &@block
    end

    def it(description = nil, &block)
      @test_cases << ItBlock.new(self, description, block, @filename, listeners: listeners)
    end

    def xit(description, &block); end
  end
end
