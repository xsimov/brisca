require 'game'

describe "the player object" do

  it "can have a deck linked to it" do
    daniel = Player.new
    this_deck = Deck.new
    expect(daniel.assign_deck this_deck).to eq(this_deck)
  end

  context "upon having a deck assigned" do
    before(:each) do
      @deck = Deck.new
      @daniel = Player.new
      @daniel.assign_deck @deck
    end

    it "has a three-something hand at the beginning" do
      @daniel.setup_first_hand
      expect(@daniel.shows_all_hand.length).to eq(3)
    end

    it "has cards in its hand" do
      @daniel.shows_all_hand.each do |card|
        expect(card).to be_a(Card)
      end
    end

    it "can set up its first hand by drawing 3 cards" do
      expect(@daniel.setup_first_hand).to eq(:ok)
    end

    it "chooses from its hand when asked to play" do
      @daniel.setup_first_hand
      @daniels_hand = []
      @daniel.shows_all_hand.each do |card|
        @daniels_hand << card
      end
      expect(@daniels_hand).to include(@daniel.play_a_card)
    end

    it "the card it chose disappears from its hand" do
      played_card = @daniel.play_a_card
      expect(@daniel.shows_all_hand).not_to include(played_card)
    end

    it "still has 3 cards on its hand after playing" do
      @daniel.setup_first_hand
      @daniel.play_a_card
      expect(@daniel.shows_all_hand.count).to eq(3)
    end
  end
end