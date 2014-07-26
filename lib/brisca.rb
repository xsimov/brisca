require 'pry'

WHO_WINS = [2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 3, 1]

class Card
	attr_accessor :num, :pal, :rank, :player
	def initialize(num, pal)
		@num = num
		@pal = pal
	end

end


class Deck
	attr_accessor :all_deck, :drawn
	def initialize
		@all_deck = []
		@drawn = []
		(1..12).to_a.each do |num|
			[:orus, :espases, :copes, :bastos].each do |pal|
				@all_deck << Card.new(num, pal)
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
end

class Round

	def same_pal
		@played_cards.each do |card|
			card.rank = WHO_WINS.index card.num
		end
		@played_cards.sort! {|f, s| s.rank <=> f.rank}
		"Player #{@played_cards[0].player}"
	end

	def self.ruling_pal(pal)
		@@ruling_pal = pal
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
		all_pals = [@played_cards[0].pal]
		@played_cards.each do |card|
			all_the_same = false unless all_pals.include? card.pal
			all_pals.push(card.pal)
		end
		return same_pal if all_the_same
		return dif_pal
	end

	def dif_pal
		partial_ruling = @played_cards[0].pal
		initial_n = @played_cards.length
		reduced = @played_cards.select { |card| card.pal==@@ruling_pal }
		if (initial_n > reduced.length)&&(reduced.length > 0)
			@played_cards = reduced
			return same_pal
		end
		@played_cards.select! { |card| card.pal==partial_ruling }
		return same_pal
	end

end

class Player
	attr_accessor :hand
	def initialize(deck)
		@hand = []
		3.times { @hand.push(deck.draw_a_card) }
	end
end