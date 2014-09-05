describe "the game" do
  context "basics to start a game" do

    before :each do
      @deck = Deck.new
      @players = []
      2.times { @players << Player.new }
    end

    it "accepts a deck and some players" do
      expect(Game.new @deck, @players).to be_a(Game)
    end
  end
end