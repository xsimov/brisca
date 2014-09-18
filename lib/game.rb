require 'pry'
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
    played_cards = select_round_cards
    winner = Round.new.resolve played_cards
    @players[winner].collect played_cards
    refill_hands
    @players[winner]
  end

  def play
    (48/@players.length).times{ play_a_round }
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
    @players.each do |player|
      new_card = @deck.draw_a_card
      if new_card
        player.hand << new_card
      elsif @last_card
        player.hand << @last_card
        @last_card = nil
      end
    end
  end

  def select_round_cards
    playing = []
    @players.each do |player|
      playing << player.play_a_card
    end
    playing
  end
end