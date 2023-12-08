# frozen_string_literal: true

module Day8
  # Desert map traversal
  class Part1
    def initialize(lines)
      @directions = lines.next.chomp.each_char

      @nodes = {}
      lines.each do |l|
        match = l.match(/(\w+)\s*=\s*\((\w+),\s*(\w+)\)/)
        next unless match

        this_node, left_node, right_node = match.values_at(1, 2, 3)

        @nodes[this_node] = [left_node, right_node]
      end

      reset
    end

    attr_accessor :node

    def reset
      @node = 'AAA'
    end

    def done?
      @node == 'ZZZ'
    end

    def next_direction
      @directions.next
    rescue StopIteration
      @directions.rewind
      @directions.next
    end

    def next_node
      raise StopIteration if done?

      advance!(next_direction == 'R' ? 1 : 0)
    end

    def advance!(direction)
      @node = @nodes[@node][direction]
    end

    def steps_to_end
      n = 0
      loop do
        next_node
        n += 1
      end
      n
    end

    def self.result(file)
      new(file.each_line).steps_to_end
    end
  end
end
