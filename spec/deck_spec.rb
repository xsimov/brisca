require_relative '../lib/deck'

describe "the card deck" do

	before(:each) do
		@deck = Deck.new
	end

	it "has 48 cards" do
		expect(@deck.all_deck.length).to eq(48)
	end

	it "never draws the same card twice" do
		drawn_cards = @deck.draw_some_cards 48
		check = true
		@deck.all_deck.each do |card|
			check = false unless drawn_cards.include? card
		end
		expect(check).to eq(true)
	end
end
