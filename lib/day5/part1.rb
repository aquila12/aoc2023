# frozen_string_literal: true

require_relative 'mapper'

module Day5
  # Follow seed numbers through several range mappings
  class Part1
    def seeds(line)
      line.scan(/\d+/).map(&:to_i)
    end

    def maps(lines)
      maps = {}

      loop do
        line = lines.next.chomp
        next unless line =~ /\bmap:$/

        from, to = line.split.first.split('-to-')
        maps[from] = Mapper.new(to, lines)
      end

      maps
    end

    def map(value, type, target, maps)
      type = type.to_s
      target = target.to_s

      while maps.key?(type) && type != target
        map = maps[type]
        type = map.output
        value = map[value]
      end

      value
    end

    def lowest(lines)
      seeds = seeds(lines.next)
      maps = maps(lines)

      seeds.map { |n| map(n, :seed, :location, maps) }.min
    end
  end
end
