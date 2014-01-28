module Tengu
  class DescribeBlock
    def initialize(description, block)
      @description = description
      @block = block
      @test_cases = []
      @before_hooks = []
      @after_hooks = []
      load_test_cases
    end

    def test_case_count
      @test_cases.count
    end

    def before(&block)
      @before_hooks << block
    end

    def after(&block)
      @after_hooks << block
    end

    def run(listeners = [])
      run_test_cases(listeners)
    end

    def load_test_cases
      instance_eval &@block
    end

    def run_test_cases(listeners = [])
      @test_cases.each do |test_case|
        @before_hooks.each { |hook| hook.call }
        test_case.run(listeners)
        @after_hooks.each { |hook| hook.call }
      end
    end

    def it(description, &block)
      @test_cases << ItBlock.new(description, block)
    end

    def xit(description, &block); end

    def success_count
      @test_cases.count { |test_case| test_case.success? }
    end

    def test_count
      @test_cases.count { |test_case| !test_case.pending? }
    end

    def pending_count
      @test_cases.count { |test_case| test_case.pending? }
    end
  end
end