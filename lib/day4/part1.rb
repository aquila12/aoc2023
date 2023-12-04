# frozen_string_literal: true

require_relative 'card'

module Day4
  # Part 1 solution
  class Part1
    def sum(enum)
      enum.sum { |l| Card.new(l).points }
    end

    def result(file)
      sum file.each_line
    end
  end
end
