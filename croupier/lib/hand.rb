require_relative 'card'

require_relative 'hand_type'


class Hand

  HAND_TYPES = [HandType::FourOfAKind, HandType::FullHouse, HandType::Flush, HandType::Straight, HandType::ThreeOfAKind, HandType::TwoPair, HandType::Pair, HandType::HighCard]

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
    @value = @cards[-1].value

    if straightFlush?
      @rank = 8
    else
      @rank = hand_type.rank
      @value = hand_type.value
    end
  end

  def hand_type
    HAND_TYPES.each do |hand_type_class|
      hand_type = hand_type_class.new @cards
      if hand_type.handles?
        return hand_type
      end
    end
  end

  def straightFlush?
    return (flush? and straight?)
  end

  def flush?
    count = { 'Hearts' => 0, 'Clubs' => 0, 'Diamonds' => 0, 'Spades' => 0 }
    @cards.each do |card|
      count[card.suit] += 1
    end

    count.each_value do |suit_count|
      if suit_count >= 5
        return true
      end
    end

    return false
  end

  def straight?
    straight_value > 0
  end

  def straight_value
    count = 1
    last_value = 0
    value = 0

    if has_ace()
      count += 1
      last_value = 1
    end

    @cards.each do |card|
      if card.value == last_value + 1
        count += 1
      else
        count = 1
      end
      last_value = card.value

      if count >= 5
        value = card.value
      end
    end
    value
  end

  def has_ace
    @cards[-1].rank == 'Ace'
  end
end