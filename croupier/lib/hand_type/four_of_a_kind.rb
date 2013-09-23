
module HandType
  class FourOfAKind < Base

    def handles?
      nOfAKind? 4
    end

    def rank
      7
    end

    def value
      highestSameValue 4
    end

  end
end