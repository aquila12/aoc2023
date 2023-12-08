# frozen_string_literal: true

module Day8
  class Part1
    START_NODE = 'AAA'
    STOP_NODE = 'ZZZ'

    def initialize(lines)
      @directions = lines.next.chomp.each_char

      @nodes = {}

      n = 0
      lines.each do |l|
        match = l.match(/(\w+)\s*=\s*\((\w+),\s*(\w+)\)/)
        next unless match

        this_node, left_node, right_node = match.values_at(1, 2, 3)

        @nodes[this_node] = [ left_node, right_node ]
      end

      @node = START_NODE
    end

    attr_accessor :node

    def next_direction
      @directions.next
    rescue StopIteration
      @directions.rewind
      @directions.next
    end

    def next_node
      raise StopIteration if @node == STOP_NODE
      @node = @nodes[@node][next_direction == 'R' ? 1 : 0]
    end

    def steps_to_end
      n = 0
      loop do
        next_node
        n += 1
      end
      n
    end
  end
end
