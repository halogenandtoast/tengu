require "tengu"

describe Tengu::DescribeBlock do
  include Tengu

  it "evaluates the code passed in" do
    test = "foo"
    code = -> (wombat) { test = wombat }
    block = DescribeBlock.new("test", code)
    expect(test).to eq block
  end

  it "will include modules" do
    marsupial = Module.new
    code = -> (wombat) { include marsupial }
    wombat = DescribeBlock.new("test", code)
    expect(wombat).to be_kind_of marsupial
  end

  it "runs before_hooks" do
    expected = -> {}
    allow(expected).to receive(:call)
    allow(ItBlock).to receive(:new).and_return(double(ItBlock, run: true))
    code = -> (wombat) { before :each, &expected; it {} }
    DescribeBlock.new("test", code).run
    expect(expected).to have_received(:call)
  end

  it "runs after_hooks" do
    expected = -> {}
    allow(expected).to receive(:call)
    allow(ItBlock).to receive(:new).and_return(double(ItBlock, run: true))
    code = -> (wombat) { after :each, &expected; it {} }
    DescribeBlock.new("test", code).run
    expect(expected).to have_received(:call)
  end
end
