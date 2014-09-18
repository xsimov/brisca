require 'game'

describe "the player object" do

  before :each do
    @daniel = Player.new
  end

  context "score meter" do
    it "exists and is initially 0" do
      expect(@daniel.score).to eq(0)
    end
  end

  context "upon having a game setup" do
    before(:each) do
      @daniel = Player.new
      @xavier = Player.new
      @game = Game.new [@daniel, @xavier]
    end

    it "has a three-something hand at the beginning" do
      expect(@daniel.shows_all_hand.length).to eq(3)
    end

    it "has cards in its hand" do
      @daniel.shows_all_hand.each do |card|
        expect(card).to be_a(Card)
      end
    end

    it "chooses from its hand when asked to play" do
      daniels_hand = []
      @daniel.shows_all_hand.each do |card|
        daniels_hand << card
      end
      expect(daniels_hand).to include(@daniel.play_a_card)
    end

    it "the card it chose disappears from its hand" do
      played_card = @daniel.play_a_card
      expect(@daniel.shows_all_hand).not_to include(played_card)
    end

    it "cannot draw a non-existing card (nil)" do
      @game.play
      expect(@daniel.shows_all_hand).not_to include(nil)
    end
  end
end