require_relative '../lib/brisca'

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

describe "the game round" do
	context "basics" do
		it "can't accept one single card play" do
			card1 = Card.new(3, :coins)
			this_round = Round.new.play(card1)
			expect(this_round).to eq("Wrong number of players!")
		end

			it "can't accept more than four cards play" do
			card1 = Card.new(3, :coins)
			this_round = Round.new.play(card1,card1,card1,card1,card1)
			expect(this_round).to eq("Wrong number of players!")
		end
	end

	context "with 2 players" do

		it "is won by the highest number, counting 1,3,12,11...4,2 if same suite" do
			card1 = Card.new(9, :coins)
			card2 = Card.new(3, :coins)
			expect(Round.new.play(card1, card2)).to eq("Player B")
		end

		it "is won by the first suite played if niether are the ruling suite" do
			card1 = Card.new(9, :cups)
			card2 = Card.new(3, :coins)
			this_round = Round.ruling_suite(:swords)
			this_round = Round.new.play(card1, card2)
			expect(this_round).to eq("Player A")
		end
	end

	context "with 3 players " do
		before(:each) do
			@deck1 = Deck.new
		end

		it "takes three cards of the same suite and outputs the rank winner" do
			card1 = Card.new(9, :coins)
			card2 = Card.new(1, :coins)
			card3 = Card.new(2, :coins)
			this_round = Round.ruling_suite(:cups)
			this_round = Round.new.play(card1, card2, card3)
			expect(this_round).to eq("Player B")
		end

		it "takes three cards of the different suite and outputs the partial ruling suite winner" do
			card1 = Card.new(9, :coins)
			card2 = Card.new(1, :swords)
			card3 = Card.new(2, :clubs)
			this_round = Round.ruling_suite(:cups)
			this_round = Round.new.play(card1, card2, card3)
			expect(this_round).to eq("Player A")
		end

		it "takes three cards of the different suite and outputs the TOTAL ruling suite winner" do
			card1 = Card.new(9, :coins)
			card2 = Card.new(1, :clubs)
			card3 = Card.new(2, :cups)
			this_round = Round.ruling_suite(:cups)
			this_round = Round.new.play(card1, card2, card3)
			expect(this_round).to eq("Player C")
		end
	end

	context "with 4 players" do
		it "accepts four parameters without crashing" do
			card1 = Card.new(9, :coins)
			card2 = Card.new(1, :swords)
			card3 = Card.new(2, :cups)
			card3 = Card.new(4, :cups)
			this_round = Round.ruling_suite(:cups)
			this_round = Round.new.play(card1, card2, card3)
			expect(this_round).to eq("Player C")
		end
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