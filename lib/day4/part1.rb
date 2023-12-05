# frozen_string_literal: true

require_relative 'card'

module Day4
  # Part 1 solution
  class Part1
    def cards(enum)
      enum.map { |l| Card.new(l) }
    end

    def sum(enum)
      cards(enum).sum(&:points)
    end

    def self.result(file)
      new.sum file.each_line
    end
  end
end
