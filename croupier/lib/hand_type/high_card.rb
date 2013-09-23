module HandType
  class HighCard < Base

    def handles?
      return true
    end

    def rank
      0
    end

    def value
      cards[-1].value
    end

  end
end
