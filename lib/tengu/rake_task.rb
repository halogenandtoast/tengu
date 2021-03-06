require "rake"
require "rake/tasklib"
require "tengu"

module Tengu
  class RakeTask < ::Rake::TaskLib
    include ::Rake::DSL if defined?(::Rake::DSL)

    def initialize(name = :spec)
      desc "Run tengu tests"
      task name do |_, task_args|
        $LOAD_PATH.unshift ::File.join(".", "spec")
        formatter = Tengu::BaseFormatter.new
        runner = Tengu::Runner.new(listeners: [formatter])
        files = Dir.glob("spec/**/*_spec.rb").map { |filename| ::File.open(filename, "r") }
        runner.run(files)
        exit runner.exit_status
      end
    end
  end
end
