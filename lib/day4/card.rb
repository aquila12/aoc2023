# frozen_string_literal: true

module Day4
  # Scratchcard implementation
  class Card
    def initialize(line)
      _, x = line.split(':')
      w, n = x.split('|')
      @winning = w.split.map(&:to_i)
      @numbers = n.split.map(&:to_i)
    end
    attr_reader :winning, :numbers

    def matches
      @matches ||= @winning & @numbers
    end

    def wins
      matches.length
    end

    def points
      1 << (wins - 1)
    end
  end
end
