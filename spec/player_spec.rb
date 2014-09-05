require 'game'

describe "the player object" do

  before(:each) do
    @deck = Deck.new
    Round.ruling_suite(@deck.draw_a_card.suite)
    @daniel = Player.new @deck
    @daniels_hand = []
    @daniel.shows_all_hand.each do |card|
      @daniels_hand << card
    end
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
    expect(@daniels_hand).to include(@daniel.play_a_card)
  end

  it "the card it chose disappears from its hand" do
    played_card = @daniel.play_a_card
    expect(@daniel.shows_all_hand).not_to include(played_card)
  end

  it "still has 3 cards on its hand after playing" do
    @daniel.play_a_card
    expect(@daniel.shows_all_hand.count).to eq(3)
  end
end