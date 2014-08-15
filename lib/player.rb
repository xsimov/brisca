class Player

  def initialize(deck)
    @hand = []
    3.times { @hand.push(deck.draw_a_card) }
  end

  def shows_all_hand
    @hand
  end

end
