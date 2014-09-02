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
    chosen_card = @hand.sample
    @hand.delete chosen_card
    @hand << @deck.draw_a_card
    chosen_card
  end

end
