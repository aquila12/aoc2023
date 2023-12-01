# frozen_string_literal: true

require_relative 'part1'

module Day1
  # Form a number from the first and last digit per line
  class Part2 < Part1
    WORDS = %w[zero one two three four five six seven eight nine]
    DIGIT = /[0-9]|#{WORDS.join('|')}/
    VALUE = WORDS.each_with_index.to_h

    def digits(line)
      [
        line.partition(DIGIT)[1],
        line.rpartition(DIGIT)[1]
      ].map do |digit|
        digit.length > 1 ? VALUE[digit] : digit.to_i
      end
    end
  end
end
