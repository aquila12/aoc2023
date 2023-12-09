# frozen_string_literal: true

require_relative 'part1'

module Day9
  # Value predictor
  class Part2 < Part1
    def sum
      @seqs.sum(&:previous_value)
    end
  end
end
