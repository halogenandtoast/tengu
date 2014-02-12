require "tengu/internals"
require "tengu/base_formatter"
require "tengu/composite_matcher"
require "tengu/describe_block.rb"
require "tengu/expectation"
require "tengu/file"
require "tengu/it_block.rb"
require "tengu/matcher"
require "tengu/matchers"
require "tengu/result"
require "tengu/runner"
require "tengu/version"

module Tengu
  def self.test(file_name, formatter = nil)
    formatters = Array(formatter)
    runner = Runner.new
    runner.run([::File.open(file_name, "r")], formatters)
  end
end
