class Player
  attr_accessor :score, :hand

  def initialize
    @hand = []
    @score = 0
    @won_cards = []
  end

  def shows_all_hand
    @hand
  end

  def play_a_card
    chosen_card = choose_a_card
    @hand.delete chosen_card
  end

  def collect cards
    cards.each do |card|
      @won_cards << card
    end
  end

  def won_cards
    @won_cards
  end

  private
  def choose_a_card
    @hand.sample
  end
end
