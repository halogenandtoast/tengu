module Tengu
  class Runner
    def initialize(options = {})
      @options = options
      @overrides = []
    end

    def notify(event, object)
      case event
      when :finished_case then reset_overrides
      when :override then record_override(*object)
      end
    end

    def run(ios, formatters = [])
      @files = ios.map { |io| Tengu::File.new(io) }
      formatters.each { |formatter| formatter.notify(:started, self) }
      @files.each { |file| file.run([self] + formatters) }
      result = Result.new(@files)
      formatters.each { |formatter| formatter.notify(:finished, result) }
      result
    end

    def record_override(object, method)
      @overrides << [object, method]
    end

    private

    def reset_overrides
      @overrides.reverse.each do |object, method|
        object.define_singleton_method method.name, method
      end
    end
  end
end
