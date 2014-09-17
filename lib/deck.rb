class Deck
  attr_accessor :all_cards

  def initialize
    @all_cards = []
    (1..12).to_a.each do |num|
      [:orus, :espases, :copes, :bastos].each do |suite|
        @all_cards << Card.new(num, suite)
      end
    end
  end

  def draw_a_card
    n = rand(48)
    return nil unless @all_cards.length > 0
    final_card = @all_cards[n]
    return @all_cards.delete final_card if final_card
    draw_a_card
  end

  def ended?
    @all_cards.length < 1
  end
end
