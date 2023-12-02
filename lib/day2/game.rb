# frozen_string_literal: true

module Day2
  # Representation of a single bag and cubes game
  class Game
    LIMIT = {
      red: 12,
      green: 13,
      blue: 14
    }

    def initialize(line)
      game, @input = line.split(':')
      @id = game.split.last.to_i
    end

    attr_reader :id

    def cube_sets
      @input.split(';').map do |set|
        set.split(',').to_h do |str|
          number, colour = str.split
          [colour.to_sym, number.to_i]
        end
      end
    end

    def possible?
      cube_sets.all? do |set|
        set.all? do |colour, num|
          num <= LIMIT[colour]
        end
      end
    end

    def smallest_set
      cube_sets.inject do |s1, s2|
        s1.merge(s2) { |_, n1, n2| [n1, n2].max }
      end
    end
  end
end
