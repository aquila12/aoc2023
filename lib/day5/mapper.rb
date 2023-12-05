# frozen_string_literal: true

module Day5
  # Maps destination ranges from source ranges
  class Mapper
    def initialize(output_type, input_lines)
      @output = output_type
      @breakpoints = []
      parse(input_lines)
    end

    attr_reader :output

    def [](input)
      bkp = @breakpoints.bsearch { |b| b.first <= input }
      bkp ? input + bkp.last : input
    end

    def to_s
      @breakpoints.map { |point, diff| "#{point} (#{diff}) " }.join
    end

    private

    def parse(input_lines)
      loop do
        line = input_lines.next.chomp
        break if line.empty?

        o, i, length = line.split.map(&:to_i)
        insert_breakpoint(i, o - i)
        insert_breakpoint(i + length, 0)
      end
    end

    def insert_breakpoint(lower, difference)
      i = @breakpoints.bsearch_index { |b| b.first <= lower }
      return @breakpoints << [lower, difference] unless i

      bkp = @breakpoints[i]
      return @breakpoints.insert(i, [lower, difference]) if bkp.first != lower

      bkp[1] = difference if difference != 0
    end
  end
end
