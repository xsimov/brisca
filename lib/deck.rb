class Deck
  attr_accessor :all_deck

  def initialize
    @all_deck = []
    (1..12).to_a.each do |num|
      [:orus, :espases, :copes, :bastos].each do |suite|
        @all_deck << Card.new(num, suite)
      end
    end
  end

  def draw_a_card
    n = rand(48)
    return nil unless @all_deck.length > 0
    final_card = @all_deck[n]
    return @all_deck.delete final_card if final_card
    draw_a_card
  end

end
