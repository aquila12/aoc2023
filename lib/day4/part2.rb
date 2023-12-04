# frozen_string_literal: true

require_relative 'card'

module Day4
  # Part 2 solution - total number of cards
  class Part2 < Part1
    def sum(enum)
      cards = cards(enum)
      copies = [1] * cards.length
      n = 0

      while n < copies.length
        times = copies[n]
        wins = cards[n].wins
        n += 1
        (n...n + wins).each { |i| copies[i] += times }
      end

      copies.sum
    end
  end
end
