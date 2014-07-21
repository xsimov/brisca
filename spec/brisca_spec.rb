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

describe "the 2 players game round" do

	it "is won by the highest number, counting 1,3,12,11...4,2 if same pal" do
		card1 = {num: 3, pal: :orus}
		card2 = {num: 1, pal: :orus}
		expect(Round.new.play(card1, card2)).to eq("Player B")
	end

	it "is won by the first pal played if niether are the ruling pal" do
		card1 = {num: 9, pal: :copes}
		card2 = {num: 1, pal: :orus}
		this_round = Round.ruling_pal(:espases)
		this_round = Round.new.play(card1, card2)
		expect(this_round).to eq("Player A")
	end
end

describe "the 3 players game round" do
	before(:each) do
		@deck1 = Deck.new
	end

	it "takes three cards of the same pal and outputs the rank winner" do
		card1 = {num: 9, pal: :orus}
		card2 = {num: 1, pal: :orus}
		card3 = {num: 2, pal: :orus}
		this_round = Round.ruling_pal(:copes)
		this_round = Round.new.play(card1, card2, card3)
		expect(this_round).to eq("Player B")
	end

	it "takes three cards of the different pal and outputs the partial ruling pal winner" do
		card1 = {num: 9, pal: :orus}
		card2 = {num: 1, pal: :espases}
		card3 = {num: 2, pal: :bastos}
		this_round = Round.ruling_pal(:copes)
		this_round = Round.new.play(card1, card2, card3)
		expect(this_round).to eq("Player A")
	end

	it "takes three cards of the different pal and outputs the TOTAL ruling pal winner" do
		card1 = {num: 9, pal: :orus}
		card2 = {num: 1, pal: :bastos}
		card3 = {num: 2, pal: :copes}
		this_round = Round.ruling_pal(:copes)
		this_round = Round.new.play(card1, card2, card3)
		expect(this_round).to eq("Player C")
	end
end