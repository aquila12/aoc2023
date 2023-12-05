# frozen_string_literal: true

require_relative 'part1'

module Day5
  # Follow seed *ranges* through several range mappings
  class Part2 < Part1
    def init_seeds(line)
      super.each_slice(2).map { |x, y| x..(x + y - 1) }
    end

    def map(range, type, target)
      type = type.to_s
      target = target.to_s

      ranges = [range]

      while maps.key?(type) && type != target
        mapper = maps[type]
        type = mapper.output
        ranges = ranges.flat_map { |r| mapper[r] }
      end

      ranges.map(&:min).min
    end
  end
end
