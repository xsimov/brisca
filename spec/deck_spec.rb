require 'game'

describe "the card deck" do

  before(:each) do
    @deck = Deck.new
  end

  it "has 48 cards" do
    expect(@deck.all_cards.length).to eq(48)
  end

  it "runs out of cards after drawing them all" do
    48.times { @deck.draw_a_card }
    expect(@deck.all_cards.length).to eq(0)
  end

  it "returns nil when trying to draw the 49th card" do
    48.times { @deck.draw_a_card }
    expect(@deck.draw_a_card).to eq(nil)
  end
end