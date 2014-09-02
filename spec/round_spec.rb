require 'game'

describe "the game round" do
  context "basics" do
    it "can't accept one single card play" do
      card1 = Card.new(3, :coins)
      this_round = Round.new.play(card1)
      expect(this_round).to eq("Wrong number of players!")
    end

      it "can't accept more than four cards play" do
      card1 = Card.new(3, :coins)
      this_round = Round.new.play(card1,card1,card1,card1,card1)
      expect(this_round).to eq("Wrong number of players!")
    end
  end

  context "with 2 players" do

    it "is won by the highest number, counting 1,3,12,11...4,2 if same suite" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(3, :coins)
      expect(Round.new.play(card1, card2)).to eq("Player B")
    end

    it "is won by the first suite played if niether are the ruling suite" do
      card1 = Card.new(9, :cups)
      card2 = Card.new(3, :coins)
      this_round = Round.ruling_suite(:swords)
      this_round = Round.new.play(card1, card2)
      expect(this_round).to eq("Player A")
    end
  end

  context "with 3 players " do
    before(:each) do
      @deck1 = Deck.new
    end

    it "takes three cards of the same suite and outputs the rank winner" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(1, :coins)
      card3 = Card.new(2, :coins)
      this_round = Round.ruling_suite(:cups)
      this_round = Round.new.play(card1, card2, card3)
      expect(this_round).to eq("Player B")
    end

    it "takes three cards of the different suite and outputs the partial ruling suite winner" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(1, :swords)
      card3 = Card.new(2, :clubs)
      this_round = Round.ruling_suite(:cups)
      this_round = Round.new.play(card1, card2, card3)
      expect(this_round).to eq("Player A")
    end

    it "takes three cards of the different suite and outputs the TOTAL ruling suite winner" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(1, :clubs)
      card3 = Card.new(2, :cups)
      this_round = Round.ruling_suite(:cups)
      this_round = Round.new.play(card1, card2, card3)
      expect(this_round).to eq("Player C")
    end
  end

  context "with 4 players" do
    it "accepts four parameters without crashing" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(1, :swords)
      card3 = Card.new(2, :cups)
      card3 = Card.new(4, :cups)
      this_round = Round.ruling_suite(:cups)
      this_round = Round.new.play(card1, card2, card3)
      expect(this_round).to eq("Player C")
    end
  end

end
