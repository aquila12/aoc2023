# frozen_string_literal: true

require_relative 'game'

module Day2
  # Work out possible coloured cube games for given a set of cubes
  class Part1
    def games(lines)
      lines.each.lazy.map { |line| Game.new(line) }
    end

    def possible_games(...)
      games(...).select(&:possible?).map(&:id)
    end

    def sum(enumerator)
      possible_games(enumerator).sum
    end

    def self.result(file)
      new.sum file.each_line
    end
  end
end
