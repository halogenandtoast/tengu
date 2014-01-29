$foo = "bar"

describe "True" do
  before(:each) do
    $foo = "baz"
  end

  it "is true" do
    expect($foo).to eq("baz")
  end

  it "includes pending" do
    pending
  end

  it "fails examples with errors" do
    raise
  end

  xit "skips others" do
    expect($foo).to eq("bar")
  end

  it "can call methods" do
    wombat
    expect($foo).to eq("numbat")
  end

  def wombat
    $foo = "numbat"
  end

  after(:each) do
    $foo = "bar"
  end
end
