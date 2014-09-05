describe "the game" do
  context "basics to start a game" do

    before :each do
      @deck = Deck.new
      @players = []
      2.times { @players << Player.new(@deck) }
    end

    it "accepts a deck" do
      expect(Game.new @deck).to be_a(Game)
    end

    it "accepts 2 players" do
      expect(Game.new @deck, @players)
    end
  end
end