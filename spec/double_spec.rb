describe Tengu::Double do
  include Tengu
  it "creates methods when passed in" do
    test_double = Double.new("test", animal: "wombat")
    expect(test_double.animal).to eq "wombat"
  end
end
