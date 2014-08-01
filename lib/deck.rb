class Card
  attr_accessor :num, :suite, :rank, :player
  def initialize(num, suite)
    @num = num
    @suite = suite
  end

end


class Deck
  attr_accessor :all_deck, :drawn
  def initialize
    @all_deck = []
    @drawn = []
    (1..12).to_a.each do |num|
      [:orus, :espases, :copes, :bastos].each do |suite|
        @all_deck << Card.new(num, suite)
      end
    end
  end

  def draw_a_card
    n = rand(48)
    return "No more cards in this deck!" if @drawn.length == 48
    unless @drawn.include? n
      final_card = @all_deck[n]
      @drawn.push(n)
    else
      final_card = draw_a_card
    end
    final_card
  end

  def draw_some_cards(number)
    @drawn_cards = []
    number.times{
      @drawn_cards.push(self.draw_a_card)
    }
    @drawn_cards
  end
end
