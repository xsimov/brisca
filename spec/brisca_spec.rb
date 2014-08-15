require_relative '../lib/round'

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

describe "the player" do

	before(:each) do
		@deck = Deck.new
		Round.ruling_suite(@deck.draw_a_card.suite)
		@daniel = Player.new @deck
	end

	it "has a three-something hand at the beginning" do
		all_hand = @daniel.shows_all_hand
		expect(all_hand.length).to eq(3)
	end

	it "has cards in its hand" do
		all_hand = @daniel.shows_all_hand
		expect(all_hand[0]).to be_a(Card)
		expect(all_hand[1]).to be_a(Card)
		expect(all_hand[2]).to be_a(Card)
	end

end