describe Tengu::Result do
  include Tengu

  it "determines the success count" do
    result = Result.new([fake_file])
    expect(result.success_count).to eq(3)
  end

  it "determines the total count" do
    result = Result.new([fake_file])
    expect(result.total_count).to eq(5)
  end

  it "determines the pending count" do
    result = Result.new([fake_file])
    expect(result.pending_count).to eq(1)
  end

  it "determines the failure count" do
    result = Result.new([fake_file])
    expect(result.failure_count).to eq(2)
  end

  def fake_file
    double(Tengu::File, success_count: 3, test_count: 5, pending_count: 1)
  end
end
