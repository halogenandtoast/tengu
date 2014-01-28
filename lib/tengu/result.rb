module Tengu
  class Result
    attr_reader :success_count, :total_count, :pending_count

    def initialize(files)
      @files = files
      @success_count = @files.inject(0) { |sum, n| sum += n.success_count }
      @total_count = @files.inject(0) { |sum, n| sum += n.test_count }
      @pending_count = @files.inject(0) { |sum, n| sum += n.pending_count }
    end

    def failure_count
      total_count - success_count
    end
  end
end
