describe Tengu::Expectation do
  include Tengu

  it "sets success to true on postive match" do
    expectation = Expectation.new("wombat")
    matcher = double(Matcher, matches?: true)
    expectation.to(matcher)
    expect(expectation.success?).to be_true
  end

  it "sets success to false on postive mismatch" do
    expectation = Expectation.new("wombat")
    matcher = double(Matcher, matches?: false)
    expectation.to(matcher)
    expect(expectation.success?).to be_false
  end

  it "sets success to true on negative mismatch" do
    expectation = Expectation.new("wombat")
    matcher = double(Matcher, matches?: false)
    expectation.not_to(matcher)
    expect(expectation.success?).to be_true
  end

  it "sets success to false on negative match" do
    expectation = Expectation.new("wombat")
    matcher = double(Matcher, matches?: true)
    expectation.not_to(matcher)
    expect(expectation.success?).to be_false
  end

  it "returns a formatted positive message" do
    expectation = Expectation.new("wombat")
    expectation.to(double(Matcher, matches?: true, description: "win"))
    expect(expectation.message).to eq 'expected "wombat" to win'
  end

  it "returns a formatted negative message" do
    expectation = Expectation.new("numbat")
    expectation.not_to(double(Matcher, matches?: true, description: "win"))
    expect(expectation.message).to eq 'expected "numbat" not to win'
  end
end
