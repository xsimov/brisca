WHO_WINS = [2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 3, 1]

class Round

  def self.setup ruling_suite
    @@number_of_rounds ||= 0
    @@ruling_suite = ruling_suite.suite
  end

  def initialize
    @@number_of_rounds += 1
  end

  def same_suite
    @played_cards.each do |card|
      card.rank = WHO_WINS.index card.num
    end
    @played_cards.sort! {|f, s| s.rank <=> f.rank}
    @played_cards[0].player
  end

  def resolve(cards)
    @played_cards = []
    cards.each.with_index do |card, i|
      card.player = i
      @played_cards.push(card)
    end
    router
  end

  def router
    all_the_same = true
    all_suites = [@played_cards[0].suite]
    @played_cards.each do |card|
      all_the_same = false unless all_suites.include? card.suite
      all_suites << card.suite
    end
    return same_suite if all_the_same
    return dif_suite
  end

  def dif_suite
    partial_ruling = @played_cards[0].suite
    initial_n = @played_cards.length
    reduced = @played_cards.select { |card| card.suite == @@ruling_suite }
    if (initial_n > reduced.length)&&(reduced.length > 0)
      @played_cards = reduced
      return same_suite
    end
    @played_cards.select! { |card| card.suite == partial_ruling }
    return same_suite
  end
end
