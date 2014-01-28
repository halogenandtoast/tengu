describe Tengu::CompositeMatcher do
  include Tengu

  it "will check existance" do
    expect(CompositeMatcher.new.matches?("wombat")).to be
  end

  it "will check >" do
    expect(5).to be > 4
    expect(3).not_to be > 4
  end

  it "will check >=" do
    expect(5).to be >= 4
    expect(5).to be >= 5
    expect(5).not_to be >= 6
  end

  it "will check <" do
    expect(5).to be < 6
    expect(6).not_to be < 6
  end

  it "will check <=" do
    expect(5).to be <= 6
    expect(6).to be <= 6
    expect(7).not_to be <= 6
  end
end
