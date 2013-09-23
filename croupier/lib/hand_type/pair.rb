
module HandType
  class Pair < Base

    def handles?
      return nOfAKind? 2
    end

    def rank
      1
    end

    def value
      highestSameValue 2
    end

  end
end