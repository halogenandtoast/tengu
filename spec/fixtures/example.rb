$foo = "bar"

describe "True" do
  before do
    $foo = "baz"
  end

  it "is true" do
    expect($foo).to eq("baz")
  end

  it "includes pending" do
    pending
  end

  xit "skips others" do
    expect($foo).to eq("bar")
  end

  after do
    $foo = "bar"
  end
end
