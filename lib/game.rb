require 'card'
require 'deck'
require 'round'
require 'player'

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
    winner = Round.new.play played_cards
    winner.collect played_cards
    winner
  end

  def play
    play_a_round until @deck.ended?
  end

  private
  def prepare_the_game
    @players.each do |player|
      player.assign_deck @deck
      player.setup_first_hand
    end
    Round.set_ruling_suite @deck.draw_a_card
    Round.set_players @players
  end
end