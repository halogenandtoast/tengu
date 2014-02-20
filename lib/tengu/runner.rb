module Tengu
  class Runner
    attr_reader :exit_status

    def initialize(options = {})
      @options = options
      @overrides = []
      @exit_status = 0
      @listeners = options.fetch(:listeners) { [] }
    end

    def notify(event, object)
      case event
      when :finished_case then reset_overrides
      when :override then record_override(*object)
      when :failure then failure
      end
    end

    def run(ios)
      @files = create_files(ios)
      notify_listeners(:started)
      run_files(@files)
    end

    def record_override(object, method)
      @overrides << [object, method]
    end

    private
    attr_reader :listeners

    def create_files(ios)
      ios.map { |io| Tengu::File.new(io, listeners: [self] + listeners) }
    end

    def notify_listeners(event)
      listeners.each { |listener| listener.notify(event, self) }
    end

    def run_files(files)
      files.each(&:run)
      create_result(files)
    end

    def create_result(files)
      result = Result.new(files)
      listeners.each { |listener| listener.notify(:finished, result) }
      result
    end

    def failure
      @exit_status = 1
    end

    def reset_overrides
      @overrides.reverse.each do |object, method|
        object.define_singleton_method method.name, method
      end
    end
  end
end
