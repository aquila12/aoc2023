# frozen_string_literal: true

require_relative 'part1'

module Day2
  class Part2 < Part1
    def powers(...)
      games(...).map(&:smallest_set).map(&:power)
    end

    def sum(enumerator)
      powers(enumerator).sum
    end
  end
end
