require 'game'

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

  context "when playing a round" do

   before :each do
      @daniel = Player.new
      @xavier = Player.new
      @deck = Deck.new
      @game = Game.new @deck, [@daniel, @xavier]
   end

   it "outputs a winner" do
     expect([@daniel, @xavier]).to include(@game.play_a_round)
   end

  end
end