
class Card

  RANKS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  SUITS = %w(Spades Hearts Diamonds Clubs)

  def initialize id
    if id.is_a? Integer
      @value = id % 13 + 2

      @suit = SUITS[id / 13]
    end

    if id.is_a? String
      rank, suit = id.split /\s+of\s+/
      set_value_by_rank_name(rank)
      @suit = suit
    end

    @rank = RANKS[@value - 2]
  end

  def set_value_by_rank_name(rank)
    if rank == "Jack" then
      @value = 11
    elsif rank == "Queen" then
      @value = 12
    elsif rank == "King" then
      @value = 13
    elsif rank == "Ace" then
      @value = 14
    else
      @value = rank.to_i
    end
  end

  def worthLessThan otherHand
    @value < otherHand.value
  end

  def to_s
    "#@rank of #@suit"
  end

  attr_reader :value
  attr_reader :rank
  attr_reader :suit


end