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
      puts "Running #{runner.test_case_count} case#{"s" unless runner.test_case_count == 1}"
    end

    def finished(result)
      puts
      puts "Finished in %0.5f seconds" % [Time.now - @started]
      puts "#{result.success_count}/#{result.total_count} cases"
      puts "#{result.failure_count} failure#{"s" unless result.failure_count == 1}"
      if result.pending_count > 0
        puts "#{result.pending_count} pending"
      end
    end
  end
end
