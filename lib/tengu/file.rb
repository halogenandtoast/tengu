module Tengu
  class File
    def initialize(io, options = {})
      @io = io
      @describes = []
      @listeners = options.fetch(:listeners) { [] }
      load_tests
    end

    def run
      describes.each(&:run)
    end

    def success_count
      describes.inject(0) { |sum, n| sum += n.success_count }
    end

    def test_count
      describes.inject(0) { |sum, n| sum += n.test_count }
    end

    def pending_count
      describes.inject(0) { |sum, n| sum += n.pending_count }
    end

    private
    attr_reader :listeners, :describes

    def code
      @code ||= @io.read
    end

    def load_tests
      instance_eval(code)
    end

    def describe(description, &block)
      @describes << DescribeBlock.new(description, block, @io.path, listeners: listeners)
    end
  end
end
