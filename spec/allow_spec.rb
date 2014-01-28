describe Tengu::Allow do
  include Tengu

  it "sets up the receiver" do
    runner = double
    object = double
    receiver = double
    allow(receiver).to receive(:setup_allow).with(runner, object).and_return("expected")
    tengu_allow = Allow.new(runner, object)
    expect(tengu_allow.to(receiver)).to eq("expected")
  end
end
