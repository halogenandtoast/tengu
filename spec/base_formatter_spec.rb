require "tengu"
require "stringio"

describe Tengu::BaseFormatter do
  it "prints . when notified of success" do
    output = StringIO.new
    formatter = Tengu::BaseFormatter.new(output)
    formatter.notify(:success)
    output.rewind
    expect(output.read).to eq(".")
  end

  it "prints F when notified of failure" do
    output = StringIO.new
    formatter = Tengu::BaseFormatter.new(output)
    formatter.notify(:failure)
    output.rewind
    expect(output.read).to eq("F")
  end

  it "prints P when notified of pending" do
    output = StringIO.new
    formatter = Tengu::BaseFormatter.new(output)
    formatter.notify(:pending)
    output.rewind
    expect(output.read).to eq("P")
  end

  it "tracks the time" do
    output = StringIO.new
    formatter = Tengu::BaseFormatter.new(output)
    allow(Time).to receive(:now).and_return(10)
    formatter.notify(:started, nil)
    allow(Time).to receive(:now).and_return(31)
    result = OpenStruct.new(total_count: 0, failure_count: 0, pending_count: 0)
    formatter.notify(:finished, result)
    output.rewind
    expect(output.read).to match(/Finished in 21.00000 seconds/)
  end

  it "tracks the example count" do
    allow(Time).to receive(:now).and_return(10)
    output = StringIO.new
    formatter = Tengu::BaseFormatter.new(output)
    formatter.notify(:started, nil)
    result = OpenStruct.new(total_count: 5, failure_count: 0, pending_count: 0)
    formatter.notify(:finished, result)
    output.rewind
    expect(output.read).to match(/5 examples/)
  end

  it "tracks the failure count" do
    allow(Time).to receive(:now).and_return(10)
    output = StringIO.new
    formatter = Tengu::BaseFormatter.new(output)
    formatter.notify(:started, nil)
    result = OpenStruct.new(total_count: 0, failure_count: 3, pending_count: 0)
    formatter.notify(:finished, result)
    output.rewind
    expect(output.read).to match(/3 failures/)
  end
end
