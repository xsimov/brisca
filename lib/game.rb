require_relative 'card'
require_relative 'deck'
require_relative 'round'
require_relative 'player'

class Game
  attr_accessor :players, :deck

  def initialize players
    @deck = Deck.new
    @players = players
    prepare_the_game
  end

  def play_a_round
    played_cards = []
    @players.each do |player|
      played_cards << player.play_a_card
    end
    winner = Round.new.resolve played_cards
    @players[winner].collect played_cards
    @players[winner]
  end

  def play
    (48/@players.length).times { play_a_round }
  end


  private
  def prepare_the_game
    set_ruling_suite @deck.draw_a_card
    Round.setup @last_card
    @players.each do |player|
      3.times do
        player.hand << @deck.draw_a_card
      end
    end
  end

  def set_ruling_suite card
    @ruling_suite = card.suite
    @last_card = card
  end

  def refill_hands
    
  end
end