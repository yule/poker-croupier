require 'rspec'

require_relative '../lib/hand'

describe 'Hand' do

  describe '#defeats?' do
    class Hand
      def should_defeat otherHand
        self.defeats?(otherHand).should == true
        otherHand.defeats?(self).should == false
      end

      def should_tie_with otherHand
        self.defeats?(otherHand).should == false
        otherHand.defeats?(self).should == false
      end
    end

    def hand(*args)
      Hand.new *args
    end

    it 'should be comparable when both are high card' do
      hand('10 of Hearts', '7 of Diamonds').
          should_defeat hand('8 of Clubs', '7 of Diamonds')
    end

    it 'should ignore kicks when the highest five equal' do
      hand('2 of Hearts', '4 of Hearts', '5 of Diamonds', '9 of Clubs', 'Jack of Hearts', 'King of Spades').
          should_tie_with hand('3 of Clubs', '4 of Hearts', '5 of Diamonds', '9 of Clubs', 'Jack of Hearts', 'King of Spades')
    end

    it 'should tie when both are high card and kicks are the same value' do
      hand('8 of Clubs','6 of Diamonds').
          should_tie_with hand('8 of Hearts', '6 of Spades')
    end

    it 'should rank a pair higher then a high card' do
      hand('8 of Clubs', '8 of Hearts').
          should_defeat hand('10 of Clubs', 'Jack of Spades')
    end

    it 'should rank a higher pair higher' do
      hand('Jack of Clubs', 'Jack of Hearts', 'Queen of Hearts').
          should_defeat hand('8 of Clubs', '8 of Hearts', 'King of Spades')
    end

    it 'should rank same value pairs based on kicks' do
      hand('Jack of Clubs', 'Jack of Hearts', '10 of Hearts').
          should_defeat hand('Jack of Spades', 'Jack of Diamonds', '9 of Hearts')

      hand('Queen of Hearts','Jack of Clubs', 'Jack of Hearts', '10 of Hearts').
          should_defeat hand('Queen of Spades', 'Jack of Spades', 'Jack of Diamonds', '9 of Hearts')

      hand('Jack of Clubs', 'Jack of Hearts', '10 of Hearts', '7 of Spades').
          should_defeat hand('Jack of Spades', 'Jack of Diamonds', '9 of Hearts', '8 of Spades')

      hand('King of Hearts','Jack of Clubs', 'Jack of Hearts').
          should_defeat hand('Queen of Spades', 'Jack of Spades', 'Jack of Diamonds')
    end

    it 'should rank two pairs over a pair' do
      hand('Jack of Spades', 'Jack of Hearts', '10 of Spades', '10 of Hearts').
          should_defeat hand('Queen of Spades', 'Queen of Hearts', 'Jack of Hearts', '10 of Diamonds')
    end

    it 'should rank a higher two pair higher' do
      hand('Queen of Spades', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs').
          should_defeat hand('King of Spades', '10 of Spades', '10 of Hearts', '9 of Diamonds', '9 of Clubs')

      #hand('Queen of Spades', '10 of Spades', '10 of Hearts', '9 of Diamonds', '9 of Clubs').
      #    should_defeat hand('King of Spades', '10 of Spades', '10 of Hearts', '8 of Diamonds', '8 of Clubs')
    end

    #it 'should rank equivalent two pairs by kicks' do
    #  hand('King of Spades', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs').
    #  should_defeat hand('Queen of Spades', 'Jack of Clubs', 'Jack of Diamonds', '8 of Hearts', '8 of Spades')
    #end

    it 'should tie equivalent two pairs with equivalent kicks' do
      hand('King of Spades', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs').
          should_tie_with hand('King of Clubs', 'Jack of Clubs', 'Jack of Diamonds', '8 of Hearts', '8 of Spades')
    end

    #it 'should ignore extra kicks when there are more than 5 cards present' do
    #  hand('Ace of Spades', 'Queen of Hearts', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs').
    #      should_tie_with hand('Ace of Clubs', 'King of Hearts', 'Jack of Clubs', 'Jack of Diamonds', '8 of Hearts', '8 of Spades')
    #end

    it 'should rank three of a kind over two pair' do
      hand('Jack of Spades', 'Jack of Hearts', 'Jack of Clubs').
          should_defeat hand('King of Hearts', 'King of Diamonds', 'Queen of Spades', 'Queen of Hearts')
    end

    it 'should rank a higher three of a kind higher' do
      hand('Queen of Diamonds', 'Jack of Spades', 'Jack of Hearts', 'Jack of Clubs').
          should_defeat hand('King of Hearts', '10 of Diamonds', '10 of Spades', '10 of Hearts')
    end

    it 'should rank a straight over three of a kind' do
      hand('8 of Clubs', '9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds').
          should_defeat hand('King of Spades', 'King of Hearts', 'King of Clubs')
    end

    context 'as a convenience for Texas Hold\'em' do
      it 'should accept longer straights' do
        hand('8 of Clubs', '9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds').
            should_defeat hand('Jack of Spades', 'Jack of Hearts', 'Jack of Clubs')
      end


      it 'should ignore extra cards at the ends of a straight' do
        hand('4 of Diamonds', '7 of Hearts', '8 of Clubs', '9 of Spades', '10 of Spades', 'Jack of Hearts', 'King of Diamonds').
            should_defeat hand('Jack of Spades', 'Jack of Hearts', 'Jack of Clubs')
      end

      it 'should ignore extra cards within the straight' do
        hand('8 of Clubs', '9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds').
            should_defeat hand('King of Spades', 'King of Hearts', 'King of Clubs')
      end
    end

    it 'should rank a higher straight higher' do
      hand('8 of Clubs', '9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds').
          should_defeat hand('6 of Diamonds', '7 of Hearts', '8 of Spades',  '9 of Hearts', '10 of Clubs', 'King of Diamonds')

      hand('8 of Clubs', '9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds').
          should_defeat hand('Ace of Clubs', '2 of Hearts', '3 of Spades', '4 of Diamonds', '5 of Hearts')
    end

    it 'should accept Ace as one' do
      hand('Ace of Clubs', '2 of Hearts', '3 of Spades', '4 of Diamonds', '5 of Hearts').
          should_defeat hand('King of Spades', 'King of Hearts', 'King of Clubs')
    end

    it 'should rank a flush over a straight' do
      hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'Jack of Hearts').
          should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds')

      hand('2 of Clubs', '4 of Clubs', '5 of Clubs', '9 of Clubs', 'Jack of Clubs').
          should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds')
    end

    it 'should ignore extra cards in a flush' do
      hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'Jack of Hearts', 'Jack of Clubs').
          should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds')

      hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'Jack of Hearts', 'King of Hearts').
          should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds')
    end

    it 'should rank higher flush higher' do
      hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'King of Hearts').
          should_defeat hand('2 of Clubs', '4 of Clubs', '5 of Clubs', '9 of Clubs', 'Jack of Clubs')

      hand('2 of Hearts', '4 of Hearts', '6 of Hearts', '9 of Hearts', 'Jack of Hearts').
          should_defeat hand('2 of Clubs', '4 of Clubs', '5 of Clubs', '9 of Clubs', 'Jack of Clubs')
    end

    it 'should rank a full house over a flush' do
      hand('10 of Diamonds', '10 of Hearts', '10 of Spades', 'Jack of Spades', 'Jack of Clubs').
          should_defeat hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'King of Hearts')
    end

    it 'should allow extra cards in a full house' do
      hand('10 of Diamonds', '10 of Hearts', '10 of Spades', 'Jack of Spades', 'Jack of Clubs', 'Jack of Hearts').
          should_defeat hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'King of Hearts')

      hand('10 of Diamonds', '10 of Hearts', '10 of Spades', 'Jack of Spades', 'Jack of Clubs', 'King of Clubs').
          should_defeat hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'King of Hearts')
    end

    it 'should rank higher full house higher' do
      hand('10 of Diamonds', '10 of Hearts', '10 of Spades', 'Jack of Spades', 'Jack of Clubs').
          should_defeat hand('9 of Diamonds', '9 of Hearts', '9 of Spades', 'King of Spades', 'King of Clubs')
    end

    #it 'should tie equivalent full houses even if there are extra cards' do
    #  hand('10 of Diamonds', '10 of Hearts', '10 of Spades', 'Jack of Spades', 'Jack of Clubs', 'King of Clubs').
    #      should_tie_with hand('10 of Diamonds', '10 of Hearts', '10 of Spades', 'Jack of Spades', 'Jack of Clubs', 'Ace of Clubs')
    #end

    it 'should rank four of a kind over full house' do
      hand('10 of Diamonds', '10 of Hearts', '10 of Spades', '10 of Clubs').
          should_defeat hand('Jack of Diamonds', 'Jack of Hearts', 'Jack of Spades', 'King of Spades', 'King of Clubs')
    end

    it 'should rank higher four of a kind higher' do
      hand('Jack of Diamonds', 'Jack of Hearts', 'Jack of Spades', 'Jack of Clubs', 'Queen of Hearts').
          should_defeat hand('10 of Diamonds', '10 of Hearts', '10 of Spades', '10 of Clubs', 'Ace of Spades')
    end

    #it 'should rank identical four of a kind based on kicks' do
    #  hand('Jack of Diamonds', 'Jack of Hearts', 'Jack of Spades', 'Jack of Clubs', 'Ace of Hearts', '9 of Clubs').
    #      should_defeat hand('Jack of Hearts', 'Jack of Hearts', 'Jack of Spades', 'Jack of Clubs', 'Ace of Spades', '8 of Hearts')
    #end

    it 'should rank a straight flush over four of a kind' do
      hand('10 of Spades', 'Jack of Spades', 'Queen of Spades', 'King of Spades', 'Ace of Spades').
          should_defeat hand('Jack of Diamonds', 'Jack of Hearts', 'Jack of Spades', 'Jack of Clubs', 'Queen of Hearts')
    end

    it 'should rank a higher straight flush higher' do
      hand('10 of Spades', 'Jack of Spades', 'Queen of Spades', 'King of Spades', 'Ace of Spades').
        should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Spades', 'Queen of Spades', 'King of Spades')
    end

    #it 'should not recognize a straight and a flush as a straight flush' do
    #  hand('Jack of Diamonds', 'Jack of Hearts', 'Jack of Spades', 'Jack of Clubs', 'Queen of Hearts').
    #  should_defeat hand('6 of Spades','10 of Spades', 'Jack of Spades', 'Queen of Spades', 'King of Spades', 'Ace of Hearts')
    #end

  end

end