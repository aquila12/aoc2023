# frozen_string_literal: true

module Day9
  # Value predictor
  class Part1
    # Mixin for Array
    module Sequence
      def derivative
        each_cons(2).map { |x, y| y - x }.extend Sequence
      end

      def zeroes?
        all?(&:zero?)
      end

      def next_value
        zeroes? ? 0 : last + derivative.next_value
      end
    end

    def initialize(lines)
      @seqs = lines.map { |l| l.split.map(&:to_i).extend Sequence }
    end

    def sequence(index)
      @seqs[index]
    end

    def sum
      @seqs.sum(&:next_value)
    end
  end
end
