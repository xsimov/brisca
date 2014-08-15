require 'pry'
require_relative './deck'

WHO_WINS = [2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 3, 1]

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