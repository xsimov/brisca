require 'card'
require 'deck'
require 'round'
require 'player'

class Game
  attr_accessor :players

  def initialize players
    @deck = Deck.new
    @players = players
    @players.each do |player|
      player.assign_deck @deck
      player.setup_first_hand
    end
  end

  def play_a_round
    @players.first
  end
end