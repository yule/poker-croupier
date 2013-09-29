module HandType
  class FullHouse < Base

    def handles?
      return false unless nOfAKind? 3

      value = highestSameValue 3

      highestSameValueExcept(2, value) > 0
    end

    def rank
      6
    end

    def value
      highestSameValue 3
    end
  end
end
