module HandType
  class StraightFlush < Base

    SUITS = %w(Spades Hearts Diamonds Clubs)

    def handles?

      SUITS.each do |suit|
        return true if straight_value_for_suit(suit) > 0
      end

      false

    end

    def rank
      8
    end

    private

    def straight_value_for_suit(suit)
      count = 1
      last_value = 0
      value = 0

      if has_ace_of_suit(suit)
        count += 1
        last_value = 1
      end

      cards.each do |card|
        if card.suit == suit
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
      end
      value
    end

    def has_ace_of_suit(suit)
      cards.each do |card|
        return true if card.value == 14 && card.suit == suit
      end

      false
    end
  end
end
