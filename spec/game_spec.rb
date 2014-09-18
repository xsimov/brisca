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

      before :each do
        @old_hands = []
        @players.each do |player|
          @old_hands << Array.new(player.shows_all_hand)
        end
      end

      it "asks every player for a card to play" do
        @game.play_a_round
        @players.each.with_index do |player, index|
          expect(player.shows_all_hand).not_to eq(@old_hands[index])
        end
      end

      it "assigns the played cards to the winner" do
        winner = @game.play_a_round
        winner.won_cards.each do |card|
          expect(@old_hands.flatten).to include(card)
        end
      end

      it "refills the players' hands after the round" do
        @game.play_a_round
        @players.each do |player|
          expect(player.hand.length).to eq(3)
        end
      end
    end
  end

  context "play" do

    before :each do
      @players = []
      2.times { @players << Player.new }
      @game = Game.new @players
    end

    it "keeps playing rounds until all cards are played" do
      @game.play
      expect(@players.first.won_cards.length + @players.last.won_cards.length).to be(48)
    end
  end
end