require "tengu"

describe "Tengu" do
  it "will .test a particular file" do
    file_path = "test"
    fake_file = double(::File)
    fake_runner = double(Tengu::Runner)
    allow(::File).to receive(:open).with(file_path, "r").and_return(fake_file)
    allow(Tengu::Runner).to receive(:new).and_return(fake_runner)
    allow(fake_runner).to receive(:run).with([fake_file], []).and_return("expected")
    expect(Tengu.test(file_path)).to eq("expected")
  end
end
