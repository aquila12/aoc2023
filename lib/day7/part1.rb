# frozen_string_literal: true

module Day7
  # Camel cards implementation
  class Part1
    # Representation of a hand of cards with a bid
    class Hand
      VALUES = 'abcdefghijklm'.reverse

      def initialize(string, bid, jokers: false)
        @labels = jokers ? 'AKQT98765432J' : 'AKQJT98765432'
        @num_jokers = jokers ? string.count('J') : 0

        @typecards = string.chars
        @typecards -= ['J'] if jokers

        @cards = string.tr(@labels, VALUES)
        @bid = bid.to_i
      end

      def to_s
        @cards.tr(VALUES, @labels)
      end

      attr_reader :cards, :bid

      include Comparable

      def <=>(other)
        _compare(type, other.type) || _compare(cards, other.cards) || 0
      end

      def type
        return @type if @type

        counts = @typecards.group_by(&:itself).values.map(&:length).sort
        return 10 if counts[-1].nil?

        @type = ((counts[-1] + @num_jokers) << 2) + (counts[-2] == 2 ? 1 : 0)
      end

      def _compare(one, two)
        x = one <=> two
        x.zero? ? nil : x
      end
    end

    def initialize(lines)
      @hands = lines.each.map do |l|
        make_hand(*l.split)
      end
    end

    def make_hand(hand, bid)
      Hand.new(hand, bid)
    end

    attr_reader :hands

    def score
      @hands.sort.each.with_index.sum do |hand, i|
        rank = 1 + i
        rank * hand.bid
      end
    end

    def self.result(file)
      new(file.each_line).score
    end
  end
end
