require 'rspec'

require_relative '../source/card'

describe 'Card' do

  it 'should have a rank and a value' do
    card = Card.new 8
    card.rank.should == '10'
    card.value.should == 10

    card = Card.new 11
    card.rank.should == 'King'
    card.value.should == 13

    card = Card.new 21
    card.rank.should == '10'
    card.value.should == 10
  end

  it 'should be comparable based on value' do
    lCard = Card.new 8
    rCard = Card.new 9

    lCard.worthLessThan rCard
    rCard.worthLessThan lCard

    lCard = Card.new 21
    rCard = Card.new 10

    lCard.worthLessThan rCard
    rCard.worthLessThan lCard
  end

  it 'should have a suit' do
    card = Card.new 8
    card.suit.should == "Spades"

    card = Card.new 13
    card.suit.should == "Hearts"
  end

  [
      [ '2 of Spades', '2', 'Spades'],
      [ '3 of Spades', '3', 'Spades'],
      [ 'Jack of Spades', 'Jack', 'Spades'],
      [ 'Queen of Spades', 'Queen', 'Spades'],
      [ 'King of Spades', 'King', 'Spades'],
      [ 'Ace of Spades', 'Ace', 'Spades'],
      [ 'Jack of Hearts', 'Jack', 'Hearts']
  ].each do | name, rank, suit |
    it "should create correct card when passed #{name}" do
      card = Card.new name

      card.rank.should == rank
      card.suit.should == suit
    end
  end
  
  it 'should return the name' do
    card = Card.new 22

    card.to_s.should == 'Jack of Hearts'
  end

end