require_relative 'card'

class Hand

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


  def defeats? other_hand
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
    elsif nOfAKind? 4
      @rank = 7
      @value = highestSameValue 4
    elsif fullHouse?
      @rank = 6
      @value = highestSameValue 3
    elsif flush?
      @rank = 5
    elsif straight?
      @rank = 4
      @value = straight_value
    elsif nOfAKind? 3
      @rank = 3
      @value = highestSameValue 3
    elsif has_two_pair?
      @rank = 2
      @value = highestSameValue 2
      @sub_value = highestSameValueExcept 2, @value
    elsif nOfAKind? 2
      @rank = 1
      @value = highestSameValue 2
    else
      @rank = 0
    end
  end

  def straightFlush?
    return (flush? and straight?)
  end

  def fullHouse?
    return false unless nOfAKind? 3

    value = highestSameValue 3

    highestSameValueExcept(2, value) > 0
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


  def highestSameValue(n)
    highestSameValueExcept n, 0
  end

  def highestSameValueExcept(n, skipped_value)
    value = 0
    count = 1
    last_value = 0
    @cards.each do |card|
      if card.value == last_value && card.value != skipped_value
        count += 1
        value = last_value if count == n
      else
        count = 1
        last_value = card.value
      end
    end
    value
  end

  def nOfAKind?(n)
    highestSameValue(n) > 0
  end


  def has_two_pair?
    pair_count = 0
    last_value = 0
    @cards.each do |card|
      if card.value == last_value
        pair_count += 1
      end
      last_value = card.value
    end
    return pair_count == 2
  end


end