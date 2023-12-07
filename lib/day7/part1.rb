# frozen_string_literal: true

module Day7
  # Camel cards implementation
  class Part1
    # Representation of a hand of cards with a bid
    class Hand
      LABELS = 'AKQJT98765432'
      VALUES = 'abcdefghijklm'.reverse

      def initialize(string, bid)
        @cards = string.tr(LABELS, VALUES)
        @bid = bid.to_i
      end

      def to_s
        @cards.tr(VALUES, LABELS)
      end

      attr_reader :cards, :bid

      include Comparable

      def <=>(other)
        _compare(type, other.type) || _compare(cards, other.cards) || 0
      end

      def type
        return @type if @type

        counts = @cards.chars.group_by(&:itself).values.map(&:length).sort
        @type = (counts[-1] << 2) + (counts[-2] == 2 ? 1 : 0)
      end

      def _compare(one, two)
        x = one <=> two
        x.zero? ? nil : x
      end
    end

    def initialize(lines)
      @hands = lines.each.map do |l|
        hand, bid = l.split
        Hand.new(hand, bid)
      end
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
