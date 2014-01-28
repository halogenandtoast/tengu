module Tengu
  class Runner
    def initialize(options = {})
      @options = options
    end

    def run(ios, formatters = [])
      @files = ios.map { |io| Tengu::File.new(io) }
      formatters.each { |formatter| formatter.notify(:start, self) }
      @files.each { |file| file.run(formatters) }
      result = Result.new(@files)
      formatters.each { |formatter| formatter.notify(:finished, result) }
      result
    end

    def test_case_count
      @test_case_count ||= @files.inject(0) { |sum, file| sum += file.test_case_count }
    end
  end
end
