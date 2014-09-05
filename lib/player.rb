class Player

  def initialize(deck)
    @hand = []
    @deck = deck
    3.times { @hand.push(deck.draw_a_card) }
  end

  def shows_all_hand
    @hand
  end

  def play_a_card
    chosen_card = choose_a_card
    @hand.delete chosen_card
    @hand << @deck.draw_a_card
    chosen_card
  end

  private
  def choose_a_card
    @hand.sample
  end
end
