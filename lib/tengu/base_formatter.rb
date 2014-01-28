module Tengu
  class BaseFormatter
    def initialize(out = $stdout)
      @out = out
    end

    def notify(event, object = nil)
      case event
      when :start then started(object)
      when :pending then out.print "P"
      when :success then out.print "."
      when :failure then out.print "F"
      when :finished then finished(object)
      end
    end

    private

    attr_reader :out

    def started(runner)
      @started = Time.now
    end

    def finished(result)
      out.puts
      out.puts "Finished in %0.5f seconds" % [Time.now - @started]
      out.puts "#{display(result.total_count, "example")}, #{display(result.failure_count, "failure")}"
      if result.pending_count > 0
        out.puts "#{result.pending_count} pending"
      end
    end

    def display(count, word)
      "#{count} " +
        if count == 1
          word
        else
          word + "s"
        end
    end
  end
end
