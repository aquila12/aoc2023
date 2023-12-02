# frozen_string_literal: true

module Day2
  # Work out possible coloured cube games for given a set of cubes
  class Part1
    class Game
      LIMIT = {
        red: 12,
        green: 13,
        blue: 14
      }

      def initialize(line)
        game, @input = line.split(':')
        @id = game.split(' ').last.to_i
      end

      attr_reader :id

      def cube_sets
        @input.split(';').map do |set|
          set.split(',').map do |str|
            number, colour = str.split(' ')
            [ colour.to_sym, number.to_i ]
          end.to_h
        end
      end

      def possible?
        cube_sets.all? do |set|
          set.all? do |colour, num|
            num <= LIMIT[colour]
          end
        end
      end
    end

    def games(lines)
      lines.each.lazy.map { |line| Game.new(line) }
    end

    def possible_games(...)
      games(...).select(&:possible?).map(&:id)
    end

    def sum(enumerator)
      possible_games(enumerator).sum
    end

    def result(file)
      sum file.each_line
    end
  end
end
