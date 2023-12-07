# frozen_string_literal: true

require_relative 'part1'

module Day7
  # Part 1 but enable jokers
  class Part2 < Part1
    def make_hand(hand, bid)
      Hand.new(hand, bid, jokers: true)
    end
  end
end
