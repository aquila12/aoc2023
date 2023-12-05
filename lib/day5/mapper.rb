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
      input.is_a?(Numeric) ? map_numeric(input) : map_range(input.min, input.max)
    end

    def to_s
      @breakpoints.reverse_each.map { |point, diff| "#{point} (#{diff}) " }.join
    end

    private

    def map_numeric(input)
      bkp = @breakpoints.bsearch { |b| b.first <= input }
      bkp ? input + bkp.last : input
    end

    def breakpoint_enum(min, max)
      size = @breakpoints.size
      lower_bk = @breakpoints.bsearch_index { |b| b.first <= min } || size
      upper_bk = @breakpoints.bsearch_index { |b| b.first <= max } || size

      # NB the array is stored backwards because of how bsearch works
      (upper_bk..lower_bk).reverse_each
    end

    def map_range(min, max)
      breakpoint_enum(min, max).map do |i|
        diff = @breakpoints[i]&.last || 0
        upper = i.positive? ? @breakpoints[i - 1].first : max + 1

        rmin = min
        rmax = [max, upper - 1].min
        min = rmax + 1

        (rmin + diff)..(rmax + diff)
      end
    end

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
