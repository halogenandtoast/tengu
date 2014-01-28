require "tengu"
require "stringio"

describe "BaseFormatter" do
  it "prints . when notified of success" do
    output = StringIO.new
    formatter = BaseFormatter.new(output)
    formatter.notify(:success)
    output.rewind
    expect(output.read).to eq(".")
  end

  it "prints F when notified of failure" do
    output = StringIO.new
    formatter = BaseFormatter.new(output)
    formatter.notify(:failure)
    output.rewind
    expect(output.read).to eq("F")
  end

  it "prints P when notified of pending" do
    output = StringIO.new
    formatter = BaseFormatter.new(output)
    formatter.notify(:pending)
    output.rewind
    expect(output.read).to eq("P")
  end
end
