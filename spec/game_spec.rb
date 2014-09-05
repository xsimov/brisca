describe "the game" do
  context "basics" do

    it "accepts a deck to start a game" do
      expect(Game.new deck).to be_a(Game)
    end
  end
end