module Tengu
  class DescribeBlock
    def initialize(description, block)
      @description = description
      @block = block
      @test_cases = []
      @before_each_hooks = []
      @after_each_hooks = []
      load_test_cases
    end

    def run(runner, listeners = [])
      run_test_cases(runner, listeners)
    end

    def success_count
      @test_cases.count { |test_case| test_case.success? }
    end

    def test_count
      @test_cases.count { |test_case| !test_case.pending? }
    end

    def pending_count
      @test_cases.count { |test_case| test_case.pending? }
    end

    private

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

    def run_test_cases(runner, listeners = [])
      @test_cases.each do |test_case|
        @before_each_hooks.each { |hook| hook.call }
        test_case.run(runner, listeners)
        @after_each_hooks.each { |hook| hook.call }
      end
    end

    def it(description = nil, &block)
      @test_cases << ItBlock.new(description, block)
    end

    def xit(description, &block); end
  end
end
