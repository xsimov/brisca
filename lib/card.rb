class Card
  attr_accessor :num, :suite, :rank, :player

  def initialize(num, suite)
    @num = num
    @suite = suite
  end

end
