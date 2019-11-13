RSpec.describe RustySymbol do
  it "has a version number" do
    expect(RustySymbol::VERSION).not_to be nil
  end

  describe "#start_with?" do
    context "without arguments" do
      it "should be return false" do
        expect(:symbol.start_with?).to eq(false)
      end
    end

    context "with single argument" do
      it "should be return true" do
        expect(:symbol.start_with?(:sym)).to eq(true)
      end

      it "should be return false" do
        expect(:symbol.start_with?(:bol)).to eq(false)
      end
    end
  end

  describe "#end_with?" do
    context "without arguments" do
      it "should be return false" do
        expect(:symbol.end_with?).to eq(false)
      end
    end

    context "with single argument" do
      it "should be return false" do
        expect(:symbol.end_with?(:sym)).to eq(false)
      end

      it "should be return true" do
        expect(:symbol.end_with?(:bol)).to eq(true)
      end
    end
  end
end
