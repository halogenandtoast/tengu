module Tengu
  class BaseFormatter
    def notify(event, object = nil)
      case event
      when :start then started(object)
      when :pending then print "P"
      when :success then print "."
      when :failure then print "F"
      when :finished then finished(object)
      end
    end

    def started(runner)
      @started = Time.now
    end

    def finished(result)
      puts
      puts "Finished in %0.5f seconds" % [Time.now - @started]
      puts "#{display(result.total_count, "example")}, #{display(result.failure_count, "failure")}"
      if result.pending_count > 0
        puts "#{result.pending_count} pending"
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
