module Tengu
  class File
    def initialize(io)
      @io = io
      @describes = []
      load_tests
    end

    def test_case_count
      @describes.inject(0) { |sum, describe| sum += describe.test_case_count }
    end

    def run(listeners = [])
      run_tests(listeners)
    end

    def code
      @code ||= @io.read
    end

    def load_tests
      instance_eval(code)
    end

    def run_tests(listeners= [])
      @describes.each { |describe| describe.run(listeners) }
    end

    def describe(description, &block)
      @describes << DescribeBlock.new(description, block)
    end

    def success_count
      @describes.inject(0) { |sum, n| sum += n.success_count }
    end

    def test_count
      @describes.inject(0) { |sum, n| sum += n.test_count }
    end

    def pending_count
      @describes.inject(0) { |sum, n| sum += n.pending_count }
    end
  end
end
