require 'game'

describe "the game" do
  context "basics to start" do

    before :each do
      @players = []
      2.times { @players << Player.new }
      @game = Game.new @players
    end

    it "accepts a deck and some players" do
      expect(@game).to be_a(Game)
    end

    it "sets up the players first hand" do
      @game.players.each do |player|
        expect(player.shows_all_hand.length).to eq(3)
      end
    end
  end

  context "when asked to play a round" do
    before :each do
      @players = []
      2.times { @players << Player.new }
      @game = Game.new @players
    end

    it "outputs a round winner" do
      winner = @game.play_a_round
      expect(@players).to include(winner)
    end

    context "actually plays a round" do

      it "asks every player for a card to play" do
        old_hands = []
        @players.each do |player|
          old_hands << player.shows_all_hand
        end
        @game.play_a_round
        @players.each.with_index do |player, index|
          expect(player.shows_all_hand).not_to eq(old_hands[index])
        end
      end

      xit "the deck has a card less for every player" do
        expect(@game.remaining_cards).to eq(48 - game.players.length)
      end

    end
  end
end