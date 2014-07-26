require 'pry'

WHO_WINS = [2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 3, 1]

class Card
	attr_accessor :num, :suite, :rank, :player
	def initialize(num, suite)
		@num = num
		@suite = suite
	end

end


class Deck
	attr_accessor :all_deck, :drawn
	def initialize
		@all_deck = []
		@drawn = []
		(1..12).to_a.each do |num|
			[:orus, :espases, :copes, :bastos].each do |suite|
				@all_deck << Card.new(num, suite)
			end
		end
	end

	def draw_a_card
		n = rand(48)
		return "No more cards in this deck!" if @drawn.length == 48
		unless @drawn.include? n
			final_card = @all_deck[n]
			@drawn.push(n)
		else
			final_card = draw_a_card
		end
		final_card
	end

	def draw_some_cards(number)
		@drawn_cards = []
		number.times{
			@drawn_cards.push(self.draw_a_card)
		}
		@drawn_cards
	end
end

class Round

	def same_suite
		@played_cards.each do |card|
			card.rank = WHO_WINS.index card.num
		end
		@played_cards.sort! {|f, s| s.rank <=> f.rank}
		"Player #{@played_cards[0].player}"
	end

	def self.ruling_suite(suite)
		@@ruling_suite = suite
	end

	def play(*cards)
		return "Wrong number of players!" if (cards.length < 2)||(cards.length > 4)
		@played_cards = []
		players = ["A", "B", "C", "D"]
		cards.each.with_index do |card, i|
			card.player = players[i]
			@played_cards.push(card)
		end
		router
	end

	def router
		all_the_same = true
		all_suites = [@played_cards[0].suite]
		@played_cards.each do |card|
			all_the_same = false unless all_suites.include? card.suite
			all_suites.push(card.suite)
		end
		return same_suite if all_the_same
		return dif_suite
	end

	def dif_suite
		partial_ruling = @played_cards[0].suite
		initial_n = @played_cards.length
		reduced = @played_cards.select { |card| card.suite==@@ruling_suite }
		if (initial_n > reduced.length)&&(reduced.length > 0)
			@played_cards = reduced
			return same_suite
		end
		@played_cards.select! { |card| card.suite==partial_ruling }
		return same_suite
	end

end

class Player

	def initialize(deck)
		@hand = []
		3.times { @hand.push(deck.draw_a_card) }
	end

	def shows_all_hand
		@hand
	end

end