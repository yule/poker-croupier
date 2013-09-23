module HandType
  class Flush < Base

    def handles?
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

    def rank
      5
    end
  end
end
