# frozen_string_literal: true

module Day10
  # Pipe following
  class Part1
    # N S W E
    DIRECTIONS = [[-1, 0], [1, 0], [0, -1], [0, 1]].freeze

    # Mixin for Array
    module Movement
      def go(direction)
        v = DIRECTIONS[direction]
        [first + v.first, last + v.last].extend Movement
      end
    end

    # Start, NW, NE, NS, WE, WS, ES (reading order, connections)
    PIPES = 'SJL|-7F'.chars.each_with_index.to_h.freeze
    PIPE_EXIT = [
      # N   S   W   E  (enter direction)
      [],
      [nil, 2, nil, 0],
      [nil, 3, 0, nil],
      [0, 1, nil, nil],
      [nil, nil, 2, 3],
      [2, nil, nil, 1],
      [3, nil, 1, nil]
    ].freeze

    def initialize(lines)
      @map = lines.map.with_index do |l, y|
        l.chars.map.with_index do |c, x|
          PIPES[c].tap do |p|
            @start = [y + 1, x + 1].extend Movement if p&.zero?
          end
        end
      end
    end

    def cell(row, col)
      return nil if row.negative? || col.negative?

      @map[row - 1][col - 1]
    end

    def start_point
      @start
    end

    def farthest_distance
      traverse.first
    end

    def farthest_point
      traverse.last
    end

    # Queue-order floodfill
    def traverse
      traversers = 4.times.map { |d| [start_point, d] }
      distance = 0

      loop do
        distance += 1

        traversers.map!(&method(:next_position))
        traversers.compact!
        traversers.uniq!(&:first)

        raise StopIteration if traversers.length == 1
      end

      [distance, traversers.first.first]
    end

    def next_position(traverser)
      pos, dir = traverser

      pnew = pos.go dir
      pipe = cell(*pnew)
      return nil unless pipe

      dnew = PIPE_EXIT[pipe][dir]
      return nil unless dnew

      [pnew, dnew]
    end
  end
end
