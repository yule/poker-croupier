require_relative 'card'

require_relative 'hand_type'


class Hand

  HAND_TYPES = [HandType::StraightFlush, HandType::FourOfAKind, HandType::FullHouse, HandType::Flush, HandType::Straight, HandType::ThreeOfAKind, HandType::TwoPair, HandType::Pair, HandType::HighCard]

  attr_reader :cards
  attr_reader :rank
  attr_reader :value

  def initialize(*args)
    @cards = []
    args.each do |card_name|
      @cards << Card.new(card_name)
    end
    @cards.sort_by! { |card| card.value }

    calculate_rank

  end


  def defeats?(other_hand)
    return self.rank > other_hand.rank unless self.rank == other_hand.rank
    return self.value > other_hand.value unless self.value == other_hand.value

    return defeats_by_kick?(other_hand)
  end


  private

  def defeats_by_kick?(other_hand)
    @cards.each_index do |index|
      break if index == 5

      if @cards[-index-1].value > other_hand.cards[-index-1].value
        return true
      elsif @cards[-index-1].value < other_hand.cards[-index-1].value
        return false
      end
    end

    return false
  end

  def calculate_rank
    @rank = hand_type.rank
    @value = hand_type.value
  end

  def hand_type
    HAND_TYPES.each do |hand_type_class|
      hand_type = hand_type_class.new @cards
      if hand_type.handles?
        return hand_type
      end
    end
  end
end