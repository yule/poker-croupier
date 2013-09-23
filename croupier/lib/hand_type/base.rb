module HandType
  class Base
    attr_reader :cards

    def initialize(cards)
      @cards = cards
    end

    def nOfAKind?(n)
      highestSameValue(n) > 0
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
  end
end