require_relative '../lib/brisca'

describe "the card deck" do

	before(:each) do
		@current_deck = Deck.new
	end

	it "has 48 cards" do
		expect(@current_deck.all_deck.length).to eq(48)
	end

	it "never draws the same card twice" do
		@drawn_cards = []
		48.times{
			@drawn_cards.push(@current_deck.draw_a_card)
		}
		check = true
		@current_deck.all_deck.each do |card|
			check=false unless @drawn_cards.include? card
		end
		expect(check).to eq(true)
	end
end

describe "the game round" do
	context "basics" do
		it "can't accept one single card play" do
			card1 = Card.new(3, :orus)
			this_round = Round.new.play(card1)
			expect(this_round).to eq("Wrong number of players!")
		end

			it "can't accept more than four cards play" do
			card1 = Card.new(3, :orus)
			card2 = Card.new(3, :orus)
			card3 = Card.new(3, :orus)
			card4 = Card.new(3, :orus)
			card5 = Card.new(3, :orus)
			this_round = Round.new.play(card1,card2,card3,card4,card5)
			expect(this_round).to eq("Wrong number of players!")
		end
	end

	context "with 2 players" do

		it "is won by the highest number, counting 1,3,12,11...4,2 if same pal" do
			card1 = Card.new(9, :orus)
			card2 = Card.new(3, :orus)
			expect(Round.new.play(card1, card2)).to eq("Player B")
		end

		it "is won by the first pal played if niether are the ruling pal" do
			card1 = Card.new(9, :copes)
			card2 = Card.new(3, :orus)
			this_round = Round.ruling_pal(:espases)
			this_round = Round.new.play(card1, card2)
			expect(this_round).to eq("Player A")
		end
	end

	context "with 3 players " do
		before(:each) do
			@deck1 = Deck.new
		end

		it "takes three cards of the same pal and outputs the rank winner" do
			card1 = Card.new(9, :orus)
			card2 = Card.new(1, :orus)
			card3 = Card.new(2, :orus)
			this_round = Round.ruling_pal(:copes)
			this_round = Round.new.play(card1, card2, card3)
			expect(this_round).to eq("Player B")
		end

		it "takes three cards of the different pal and outputs the partial ruling pal winner" do
			card1 = Card.new(9, :orus)
			card2 = Card.new(1, :espases)
			card3 = Card.new(2, :bastos)
			this_round = Round.ruling_pal(:copes)
			this_round = Round.new.play(card1, card2, card3)
			expect(this_round).to eq("Player A")
		end

		it "takes three cards of the different pal and outputs the TOTAL ruling pal winner" do
			card1 = Card.new(9, :orus)
			card2 = Card.new(1, :bastos)
			card3 = Card.new(2, :copes)
			this_round = Round.ruling_pal(:copes)
			this_round = Round.new.play(card1, card2, card3)
			expect(this_round).to eq("Player C")
		end
	end

	context "with 4 players" do
		it "accepts four parameters without crashing" do
			card1 = Card.new(9, :orus)
			card2 = Card.new(1, :espases)
			card3 = Card.new(2, :copes)
			card3 = Card.new(4, :copes)
			this_round = Round.ruling_pal(:copes)
			this_round = Round.new.play(card1, card2, card3)
			expect(this_round).to eq("Player C")
		end
	end

end

describe "the player" do

	before(:each) do
		@deck = Deck.new
		@daniel = Player.new @deck
	end

	it "has a three-something hand at the beginning" do
		expect(@daniel.hand.length).to eq(3)
	end

	it "has cards in its hand" do
		expect(@daniel.hand[0]).to be_a(Card)
	end

	it "has one only one different card after playing one round" do
		hand_before = @daniel.hand
		
	end

end