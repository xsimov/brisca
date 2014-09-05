class Player
  attr_accessor :score

  def initialize
    @hand = []
  end

  def shows_all_hand
    @hand
  end

  def setup_first_hand
    3.times do
      @hand << @deck.draw_a_card
    end
    :ok
  end

  def play_a_card
    chosen_card = choose_a_card
    @hand.delete chosen_card
    @hand << @deck.draw_a_card
    chosen_card
  end

  def assign_deck deck
    @deck = deck
  end

  private
  def choose_a_card
    @hand.sample
  end
end
