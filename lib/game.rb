require 'card'
require 'deck'
require 'round'
require 'player'

class Game
  attr_accessor :deck

  def initialize deck, players
    @deck = deck
    @players = players
  end

  def play_a_round
    
  end
end