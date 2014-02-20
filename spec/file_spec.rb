describe Tengu::File do
  include Tengu

  it "reads the tests" do
    code = file_double("describe('test') {}")
    file = File.new(code)
    expect(code).to have_received(:read)
  end

  it "runs the tests" do
    describe_block = double(DescribeBlock, run: true)
    allow(DescribeBlock).to receive(:new).and_return(describe_block)
    code = file_double("describe('test') {}")
    runner = double
    file = File.new(code, listeners: [runner])
    file.run
    expect(describe_block).to have_received(:run)
  end

  it "returns the success count" do
    describe_block = double(DescribeBlock, run: true, success_count: 5)
    allow(DescribeBlock).to receive(:new).and_return(describe_block)
    code = file_double("describe('test') {}")
    file = File.new(code)
    file.run
    expect(file.success_count).to eq 5
  end

  it "returns the test count" do
    describe_block = double(DescribeBlock, run: true, test_count: 7)
    allow(DescribeBlock).to receive(:new).and_return(describe_block)
    code = file_double("describe('test') {}")
    file = File.new(code)
    file.run
    expect(file.test_count).to eq 7
  end

  def file_double(code)
    double(File, path: '/tmp/var', read: code)
  end
end
