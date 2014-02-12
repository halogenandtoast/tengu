describe Tengu::File do
  include Tengu

  it "reads the tests" do
    code = double(File, read: "describe('test') {}")
    file = File.new(code)
    expect(code).to have_received(:read)
  end

  it "runs the tests" do
    describe_block = double(DescribeBlock, run: true)
    allow(DescribeBlock).to receive(:new).and_return(describe_block)
    code = double(File, read: "describe('test') {}")
    file = File.new(code)
    runner = double
    file.run([runner])
    expect(describe_block).to have_received(:run).with([runner])
  end

  it "returns the success count" do
    describe_block = double(DescribeBlock, run: true, success_count: 5)
    allow(DescribeBlock).to receive(:new).and_return(describe_block)
    code = double(File, read: "describe('test') {}")
    file = File.new(code)
    file.run(double)
    expect(file.success_count).to eq 5
  end

  it "returns the test count" do
    describe_block = double(DescribeBlock, run: true, test_count: 7)
    allow(DescribeBlock).to receive(:new).and_return(describe_block)
    code = double(File, read: "describe('test') {}")
    file = File.new(code)
    file.run(double)
    expect(file.test_count).to eq 7
  end
end
