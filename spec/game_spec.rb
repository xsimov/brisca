describe "the game" do
  context "basics" do

    before :each do
      @deck = Deck.new
    end

    it "accepts a deck to start a game" do
      expect(Game.new @deck).to be_a(Game)
    end
  end
end