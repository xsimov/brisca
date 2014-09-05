require 'card'
require 'deck'
require 'round'
require 'player'

class Game
  attr_accessor :deck

  def initialize deck
    @deck = deck
  end
end