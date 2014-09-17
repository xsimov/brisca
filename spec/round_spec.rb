require 'game'

describe "the round" do

  before :each do
    @daniel = Player.new
    @xavier = Player.new
    @ness = Player.new
    @guillem = Player.new
    @game = Game.new [@daniel, @xavier, @ness, @guillem]
    Round.setup(Card.new(2, :swords))
  end

  context "with 2 players" do

    it "is won by the highest number, counting 1,3,12,11...4,2 if same suite" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(3, :coins)
      expect(Round.new.resolve([card1, card2])).to eq(1)
    end

    it "is won by the first suite played if niether are the ruling suite" do
      card1 = Card.new(9, :cups)
      card2 = Card.new(3, :coins)
      this_round = Round.new.resolve([card1, card2])
      expect(this_round).to eq(0)
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
      this_round = Round.new.resolve([card1, card2, card3])
      expect(this_round).to eq(1)
    end

    it "takes three cards of the different suite and outputs the partial ruling suite winner" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(1, :cubs)
      card3 = Card.new(2, :clubs)
      this_round = Round.new.resolve([card1, card2, card3])
      expect(this_round).to eq(0)
    end

    it "takes three cards of the different suite and outputs the TOTAL ruling suite winner" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(1, :clubs)
      card3 = Card.new(3, :swords)
      this_round = Round.new.resolve([card1, card2, card3])
      expect(this_round).to eq(2)
    end
  end

  context "with 4 players" do
    it "accepts four parameters without crashing" do
      card1 = Card.new(9, :coins)
      card2 = Card.new(1, :cups)
      card3 = Card.new(2, :swords)
      card3 = Card.new(4, :swords)
      this_round = Round.new.resolve([card1, card2, card3])
      expect(this_round).to eq(2)
    end
  end

  

end
